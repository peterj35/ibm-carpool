class AddTitleToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :title, :text
  end
end
