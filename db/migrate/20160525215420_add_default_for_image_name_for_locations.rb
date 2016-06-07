class AddDefaultForImageNameForLocations < ActiveRecord::Migration
  def change
    change_column :locations, :image_name, :string, default: "ibm.png"
  end
end
