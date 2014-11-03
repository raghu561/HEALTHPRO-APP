class AddReadcolsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :read_flag, :integer
    add_column :users, :unread_count, :integer
  end
end
