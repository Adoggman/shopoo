# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130302231112) do

  create_table "addresses", :force => true do |t|
    t.string   "streetaddress"
    t.string   "streetaddress2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "billing_infos", :force => true do |t|
    t.string   "cardtype"
    t.string   "cardnumber"
    t.string   "cardname"
    t.string   "expiration"
    t.string   "securitycode"
    t.integer  "address_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "billing_infos", ["address_id"], :name => "index_billing_infos_on_address_id"

  create_table "cart_promos", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "promo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.decimal  "cost"
    t.string   "description"
    t.string   "category"
    t.integer  "stock"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "promos", :force => true do |t|
    t.string   "code"
    t.integer  "item_id"
    t.decimal  "discount"
    t.date     "expiration"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "promos", ["item_id"], :name => "index_promos_on_item_id"

  create_table "quantities", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "email"
    t.integer  "billing_info_id"
    t.integer  "address_id"
    t.integer  "cart_id"
    t.boolean  "admin"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
