class RemoveWorkTimesFromOffers < ActiveRecord::Migration
  def change
    remove_column :offers, :work_start
    remove_column :offers, :work_end
  end
end
