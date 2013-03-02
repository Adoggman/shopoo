class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :code
      t.references :item
      t.decimal :discount

      t.timestamps
    end
    add_index :promos, :item_id
  end
end
