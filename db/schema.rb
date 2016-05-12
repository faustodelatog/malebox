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

ActiveRecord::Schema.define(version: 20160512050528) do

  create_table "categoria", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "orden"
    t.string   "foto_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categoria_productos", force: :cascade do |t|
    t.integer  "categorium_id"
    t.integer  "producto_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categoria_productos", ["categorium_id"], name: "index_categoria_productos_on_categorium_id"
  add_index "categoria_productos", ["producto_id"], name: "index_categoria_productos_on_producto_id"

  create_table "fotos", force: :cascade do |t|
    t.string   "url"
    t.integer  "producto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "fotos", ["producto_id"], name: "index_fotos_on_producto_id"

  create_table "pedidos", force: :cascade do |t|
    t.date     "fecha"
    t.string   "nombre"
    t.string   "email"
    t.string   "telefono"
    t.decimal  "descuento"
    t.decimal  "costo_entrega"
    t.string   "nombre_entrega"
    t.text     "direccion_entrega"
    t.date     "fecha_entrega"
    t.text     "items"
    t.string   "estado"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "foto_url"
    t.decimal  "precio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "isAdmin",                default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
