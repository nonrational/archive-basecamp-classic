require "fileutils"

class Abc::Attachment < Abc::ApplicationRecord
  def self.download_all
    downloaded_this_minute = 0
    all.each do |a|
      next if a.file_exists?

      a.binwrite
      downloaded_this_minute += 1

      if downloaded_this_minute > 30
        puts "Hit #{downloaded_this_minute} this minute. Sleeping for 60s..."
        sleep 60
        downloaded_this_minute = 0
      end
    end
  end

  def binwrite
    raise if project_slug.empty?

    FileUtils.mkdir_p directory

    BasecampClient.get(download_url, follow_redirects: true).tap do |response|
      if response.response.code != "200" || response.response.content_length != byte_size
        binding.pry
      end

      size = File.binwrite(filepath, response.body)
      puts download_url + "\n\t→ " + filepath + "\n\t→ #{size}"
    end
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
