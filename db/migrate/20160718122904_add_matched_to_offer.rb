class AddMatchedToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :matched, :boolean, :default => false
  end
end
