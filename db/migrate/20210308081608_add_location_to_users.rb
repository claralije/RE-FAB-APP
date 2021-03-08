class AddLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :location, :string
    add_column :users, :phone_number, :string
    add_column :users, :bio, :text
    add_column :users, :school, :string
    add_column :users, :average_rating, :float
  end
end
