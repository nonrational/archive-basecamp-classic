class AddProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.datetime :created_on
      t.datetime :last_changed_on

      t.string :name
      t.string :status

      t.string :company_name
      t.integer :company_id

      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :todos do |t|
      t.integer :completed_count
      t.integer :uncompleted_count

      t.integer :milestone_id
      t.integer :project_id

      t.string :description
      t.string :name
      t.integer :position
      t.boolean :tracked
      t.boolean :completed

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
