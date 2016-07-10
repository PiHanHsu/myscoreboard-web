class AddGooglePlaceIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :google_place_id, :string
    remove_column :locations, :google_id
  end
end
