class CreatePersons < ActiveRecord::Migration[6.0]
  def change
    create_table :persons do |t|
      t.integer :client_id
      t.boolean :deleted
      t.string :im_handle
      t.string :im_service
      t.string :phone_number_fax
      t.string :phone_number_home
      t.string :phone_number_mobile
      t.string :phone_number_office
      t.string :phone_number_office_ext
      t.string :title
      t.string :uuid
      t.string :first_name
      t.string :last_name
      t.string :time_zone_name
      t.integer :signal_identity_id
      t.string :email_address
      t.string :avatar_url
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
