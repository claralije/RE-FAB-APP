class AddDefaultValueToStatusOnDeals < ActiveRecord::Migration[6.0]
  def change
    change_column :deals, :status, :string, default: 'pending'
  end
end
