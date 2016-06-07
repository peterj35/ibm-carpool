class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.text :brand
      t.integer :year
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
