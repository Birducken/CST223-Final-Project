# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_29_072157) do
  create_table "games", id: :string, force: :cascade do |t|
    t.string "assets"
    t.string "public_sales"
    t.string "private_sales"
    t.string "deck"
    t.string "vault"
    t.string "discard"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
