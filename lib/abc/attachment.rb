require "fileutils"

class Abc::Attachment < ActiveRecord::Base
  def self.download_all
    downloaded_this_minute = 0
    all.each do |a|
      a.stream_download
      downloaded_this_minute += 1
      if downloaded_this_minute > 50
        puts "rate-limit sleeping for 60s"
        sleep 60
        downloaded_this_minute = 0
      end
    end
  end

  def stream_download
    return if file_exists?
    raise if project_slug.empty?

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
    @directory ||= File.join("projects", project_slug, "attachments", created_on.strftime("%Y-%m").split("-"))
  end

  def filename
    @filename ||= "#{id}__#{created_on.strftime("%Y-%m-%d")}__#{original_filename.tr(" ", "_")}"
  end

  def file_exists?
    File.exist?(filepath)
  end
end
