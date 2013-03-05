class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :encrypted_password
      t.string :salt
      t.string :email
      t.integer :billing_info_id
      t.integer :address_id
      t.integer :cart_id
      t.boolean :admin

      t.timestamps
    end
  end
end
