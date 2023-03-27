class BasecampProjectAttachmentIterator
  attr_reader :project_slug

  def self.default
    new(ENV["BASECAMP_DEFAULT_PROJECT_SLUG"])
  end

  def initialize(project_slug)
    @project_slug = project_slug
    @index = Attachment.maximum(:batch_id) || 0
    @attachments = []
    @done = false
    @next_batch = []
  end

  def fetch_all
    until @done
      @next_batch.map(&:symbolize_keys).each do |rr|
        # record which batch we found this attachment in so we can resume
        rr[:batch_id] = @index

        Abc::Attachment.create_with(rr.except(:id)).find_or_create_by(id: rr[:id]).tap do |a|
          puts "#{a.id} - #{a.filename}"
        end
      end

      @next_batch = fetch_and_increment
      @done = @next_batch.empty?
    end
  end

  private

  def fetch_and_increment
    result = fetch(@index)
    # binding.pry if result["attachments"].empty?
    @index += 100
    result["attachments"]
  end

  def fetch(offset)
    BasecampClient.get("/projects/#{project_slug}/attachments.xml?n=#{offset}")
  end
end
