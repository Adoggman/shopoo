class CreateBillingInfos < ActiveRecord::Migration
  def change
    create_table :billing_infos do |t|
      t.string :cardnumber
      t.string :cardname
      t.string :expiration
      t.string :securitycode
      t.references :address

      t.timestamps
    end
    add_index :billing_infos, :address_id
  end
end
