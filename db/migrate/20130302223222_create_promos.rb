class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :code
      t.references :item
      t.decimal :discount, :scale => 2
      t.date :expiration

      t.timestamps
    end
    add_index :promos, :item_id
  end
end
