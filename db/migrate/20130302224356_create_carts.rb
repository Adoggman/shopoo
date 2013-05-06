class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.datetime :order_date
      t.timestamps
    end
  end
end
