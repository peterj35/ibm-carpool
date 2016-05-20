class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.text :brief
      t.references :user, index: true, foreign_key: true
      t.time :work_start
      t.time :work_end
      t.boolean :flexible

      t.timestamps null: false
    end
  end
end
