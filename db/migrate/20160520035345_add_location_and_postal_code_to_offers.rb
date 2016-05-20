class AddLocationAndPostalCodeToOffers < ActiveRecord::Migration
  def change
    add_reference :offers, :location, index: true, foreign_key: true
    add_column :offers, :postal_code, :string
  end
end
