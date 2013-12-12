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

ActiveRecord::Schema.define(:version => 20131212233342) do

  create_table "dragon_rental_requests", :force => true do |t|
    t.integer  "dragon_id",                         :null => false
    t.date     "start_date",                        :null => false
    t.date     "end_date",                          :null => false
    t.string   "status",     :default => "PENDING", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "dragon_rental_requests", ["dragon_id"], :name => "index_dragon_rental_requests_on_dragon_id"
  add_index "dragon_rental_requests", ["end_date"], :name => "index_dragon_rental_requests_on_end_date"
  add_index "dragon_rental_requests", ["start_date"], :name => "index_dragon_rental_requests_on_start_date"

  create_table "dragons", :force => true do |t|
    t.integer  "age",                       :null => false
    t.string   "color",                     :null => false
    t.string   "sex",                       :null => false
    t.string   "name",                      :null => false
    t.date     "birth_date",                :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id",    :default => 1, :null => false
  end

  add_index "dragons", ["user_id"], :name => "index_dragons_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "password_digest", :null => false
    t.string   "session_token",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["password_digest"], :name => "index_users_on_password_digest"
  add_index "users", ["session_token"], :name => "index_users_on_session_token"

end
