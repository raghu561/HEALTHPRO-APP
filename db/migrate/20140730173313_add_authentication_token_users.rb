class AddAuthenticationTokenUsers < ActiveRecord::Migration
  def up
    add_column :users, :authentication_token, :text
  end

  def down
  end
end
