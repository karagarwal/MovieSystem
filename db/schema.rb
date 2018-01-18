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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180118062344) do

  create_table "audis", force: :cascade do |t|
    t.integer  "code",            limit: 4
    t.integer  "number_of_seats", limit: 4
    t.integer  "theater_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audis", ["theater_id"], name: "fk_rails_a7241856b0", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "rating",     limit: 4
    t.decimal  "duration",               precision: 10
    t.string   "language",   limit: 255
    t.integer  "theater_id", limit: 4
    t.integer  "audi_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["audi_id"], name: "fk_rails_dae1886e9a", using: :btree
  add_index "movies", ["theater_id"], name: "fk_rails_d1bccfb3d5", using: :btree

  create_table "seat_types", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.integer  "audi_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seat_types", ["audi_id"], name: "fk_rails_e47b1cd1bf", using: :btree

  create_table "showtimes", force: :cascade do |t|
    t.time     "timing"
    t.integer  "movie_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "showtimes", ["movie_id"], name: "fk_rails_3fc119ff04", using: :btree

  create_table "theaters", force: :cascade do |t|
    t.string   "theater_name", limit: 255
    t.string   "address",      limit: 255
    t.string   "phone",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "seat_number",  limit: 4
    t.decimal  "price",                  precision: 10
    t.integer  "showtime_id",  limit: 4
    t.integer  "audi_id",      limit: 4
    t.integer  "movie_id",     limit: 4
    t.integer  "seat_type_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["audi_id"], name: "fk_rails_ff384906fb", using: :btree
  add_index "tickets", ["movie_id"], name: "fk_rails_c602f48ffb", using: :btree
  add_index "tickets", ["seat_type_id"], name: "fk_rails_7b4f3064c4", using: :btree
  add_index "tickets", ["showtime_id"], name: "fk_rails_dc20913428", using: :btree
  add_index "tickets", ["user_id"], name: "fk_rails_538a036fb9", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "phone",        limit: 255
    t.string   "payment_mode", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "audis", "theaters"
  add_foreign_key "movies", "audis"
  add_foreign_key "movies", "theaters"
  add_foreign_key "seat_types", "audis"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "tickets", "audis"
  add_foreign_key "tickets", "movies"
  add_foreign_key "tickets", "seat_types"
  add_foreign_key "tickets", "showtimes"
  add_foreign_key "tickets", "users"
end
