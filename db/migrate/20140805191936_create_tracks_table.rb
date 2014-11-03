class CreateTracksTable < ActiveRecord::Migration
  def up
    create_table(:tracks) do |t|
      t.string :key
      t.string :name
      t.text :coordinates
      t.integer :user_id
      t.timestamps
    end
  end

  def down
    drop_table :tracks
  end
end

