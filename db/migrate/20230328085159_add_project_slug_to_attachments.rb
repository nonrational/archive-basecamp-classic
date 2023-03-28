class AddProjectSlugToAttachments < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :project_slug, :string
  end
end
