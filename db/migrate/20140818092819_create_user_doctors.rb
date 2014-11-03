class CreateUserDoctors < ActiveRecord::Migration
  def change
    create_table :user_doctors do |t|
      t.integer :user_id
      t.integer :doctor_id
      t.timestamps
    end
  end
end
