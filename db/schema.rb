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

ActiveRecord::Schema.define(version: 20141014164659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credentials", force: true do |t|
    t.string   "encrypted_passphrase"
    t.text     "encrypted_private_key"
    t.text     "public_key"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_key_id"
  end

  add_index "credentials", ["repository_id"], name: "index_credentials_on_repository_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",     default: false
    t.integer  "user_id"
    t.string   "html_url"
    t.string   "ssh_url"
    t.string   "language"
  end

  add_index "repositories", ["user_id"], name: "index_repositories_on_user_id", using: :btree

  create_table "runs", force: true do |t|
    t.boolean  "passed"
    t.text     "result"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "revision"
    t.string   "author"
    t.text     "log"
    t.integer  "sequence"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "avatar_url"
  end

end
