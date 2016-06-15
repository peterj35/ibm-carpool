class ChangePictureUrlNameFromLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :picture_url, :image_name
  end
end
