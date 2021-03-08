class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :fabric
      t.string :description
      t.string :condition
      t.string :weight
      t.integer :quantity
      t.string :color
      t.integer :price
      t.string :status
      t.string :location
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end


