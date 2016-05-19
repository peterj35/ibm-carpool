class AddPictureAndRegionToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :picture_url, :string
    add_column :locations, :region, :string
  end
end
