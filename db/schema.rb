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

ActiveRecord::Schema.define(version: 20170128155823) do

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "scheduledDate"
    t.datetime "runDate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "fight_items", force: :cascade do |t|
    t.integer  "fight_id"
    t.integer  "gladiator_id"
    t.integer  "initiative"
    t.integer  "hp"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "died"
    t.boolean  "wounded"
    t.boolean  "won"
    t.index ["fight_id"], name: "index_fight_items_on_fight_id"
    t.index ["gladiator_id"], name: "index_fight_items_on_gladiator_id"
  end

  create_table "fight_styles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

  create_table "fights", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "sequence"
    t.string   "winner"
    t.boolean  "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "log"
    t.integer  "rounds"
    t.index ["event_id"], name: "index_fights_on_event_id"
  end

  create_table "gladiators", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.integer  "fightStyle"
    t.integer  "str"
    t.integer  "dex"
    t.integer  "spd"
    t.integer  "con"
    t.integer  "chr"
    t.integer  "intl"
    t.date     "birth"
    t.date     "firstfight"
    t.date     "death"
    t.integer  "wounds"
    t.integer  "reputation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "hitmod"
    t.integer  "strmod"
    t.integer  "exp"
    t.index ["team_id"], name: "index_gladiators_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "accountbalance"
    t.integer  "reputation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "active"
  end

end
