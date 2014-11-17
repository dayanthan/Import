class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :contact_name
      t.string :contact_email
      t.integer :user_id
      t.string :contact_type
      t.string :contact_from
      t.integer :app_user_id

      t.timestamps
    end
  end
end
