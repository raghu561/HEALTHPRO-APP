class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.string :role
      t.string :phone
      t.string :user_name
      t.string :gender
      t.string :user_type
      t.string :city
      t.string :state
      t.string :country
      t.string :lattitude
      t.string :longitude
      t.string :phone
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
