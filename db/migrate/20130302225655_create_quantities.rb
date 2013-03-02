class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.integer :cart_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
