class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :cost
      t.string :description
      t.string :category
      t.integer :stock
      t.string :url

      t.timestamps
    end
  end
end
