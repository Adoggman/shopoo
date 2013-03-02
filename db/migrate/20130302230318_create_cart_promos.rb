class CreateCartPromos < ActiveRecord::Migration
  def change
    create_table :cart_promos do |t|
      t.integer :cart_id
      t.integer :promo_id

      t.timestamps
    end
  end
end
