require "fileutils"

class Attachment < ActiveRecord::Base
  def self.download_all
    all.each(&:stream_download)
  end

  def stream_download
    return if file_exists?

    FileUtils.mkdir_p filedir

    File.open(relative_filepath, "w") do |file|
      file.binmode
      HTTParty.get(download_url, stream_body: true) do |fragment|
        file.write(fragment)
      end
    end
  end

  def relative_filepath
    File.join(filedir, filename)
  end

  def filedir
    created_on.strftime("%Y-%m-%d")
  end

  def filename
    "#{id}__#{original_filename.tr(" ", "_")}"
  end

  def file_exists?
    File.exist?(relative_filepath)
  end
end
