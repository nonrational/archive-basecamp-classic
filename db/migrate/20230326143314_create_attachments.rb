class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.integer :batch_id
      t.integer :byte_size
      t.integer :category_id
      t.integer :collection
      t.datetime :created_on
      t.boolean :current
      t.string :description
      t.string :download_url
      t.string :key
      t.string :name
      t.string :original_filename
      t.integer :owner_id
      t.string :owner_type
      t.integer :person_id
      t.boolean :private
      t.integer :project_id
      t.integer :thumbnail_key
      t.integer :version
    end
  end
end
