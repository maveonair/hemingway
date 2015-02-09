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

  create_table "credentials", force: :cascade do |t|
    t.string   "encrypted_passphrase",  limit: 255
    t.text     "encrypted_private_key"
    t.text     "public_key"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_key_id"
  end

  add_index "credentials", ["repository_id"], name: "index_credentials_on_repository_id", using: :btree

  create_table "repositories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                 default: false
    t.integer  "user_id"
    t.string   "html_url",   limit: 255
    t.string   "ssh_url",    limit: 255
  end

  add_index "repositories", ["user_id"], name: "index_repositories_on_user_id", using: :btree

  create_table "runs", force: :cascade do |t|
    t.boolean  "passed"
    t.text     "result"
    t.integer  "repository_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "revision",      limit: 255
    t.string   "author",        limit: 255
    t.text     "log"
    t.integer  "sequence"
  end

  add_index "runs", ["repository_id"], name: "index_runs_on_repository_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
    t.string   "avatar_url", limit: 255
  end

end
