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

ActiveRecord::Schema[7.1].define(version: 2025_06_19_060048) do
  create_table "emotions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.float "positive"
    t.float "neutral"
    t.float "negative"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feed_backs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.integer "ep"
    t.integer "tf"
    t.integer "con"
    t.integer "mtv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inputs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "emotion"
    t.float "maxtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.integer "ep"
    t.integer "num"
    t.integer "time"
    t.boolean "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "content"
    t.boolean "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tunings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "ep"
    t.float "T"
    t.float "M"
    t.float "C"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
