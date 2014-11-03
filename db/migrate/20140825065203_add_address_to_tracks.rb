class AddAddressToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :from_address, :text
    add_column :tracks, :to_address, :text
  end
end
