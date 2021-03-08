class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.references :user_a, null: false, foreign_key: {to_table: :users}
      t.references :user_b, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
