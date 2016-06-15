class AddSpecificLocationToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :specific_location, :text
  end
end
