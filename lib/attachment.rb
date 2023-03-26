require "fileutils"

class Attachment < ActiveRecord::Base
  def self.download_all
    all.each(&:stream_download)
  end

  def stream_download
    return if file_exists?

    FileUtils.mkdir_p directory

    File.open(filepath, "w") do |file|
      file.binmode
      HTTParty.get(download_url, stream_body: true) do |fragment|
        file.write(fragment)
      end
    end

    puts filepath
  end

  def filepath
    @filepath ||= File.join(directory, filename)
  end

  def directory
    @directory ||= File.join("downloads", created_on.strftime("%Y-%m").split('-'))
  end

  def filename
    @filename ||= "#{id}__#{created_on.strftime("%Y-%m-%d")}__#{original_filename.tr(" ", "_")}"
  end

  def file_exists?
    File.exist?(filepath)
  end
end
