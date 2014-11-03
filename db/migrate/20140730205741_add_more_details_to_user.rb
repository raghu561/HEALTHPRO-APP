class AddMoreDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :text
    add_column :users, :zip, :text
    add_column :users, :dob, :date
    add_column :users, :emergency_contact_name, :text
    add_column :users, :emergency_contact_phone, :text
  end
end
