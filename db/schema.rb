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

ActiveRecord::Schema.define(version: 20181116190012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_index "categoria_productos", ["categorium_id"], name: "index_categoria_productos_on_categorium_id", using: :btree
  add_index "categoria_productos", ["producto_id"], name: "index_categoria_productos_on_producto_id", using: :btree

  create_table "cosas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empaques", force: :cascade do |t|
    t.string   "nombre"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fotos", force: :cascade do |t|
    t.string   "url"
    t.integer  "producto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "fotos", ["producto_id"], name: "index_fotos_on_producto_id", using: :btree

  create_table "inventario_cosa_registros", force: :cascade do |t|
    t.integer  "inventario_cosa_id"
    t.integer  "tipo"
    t.integer  "cantidad"
    t.text     "notas"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "inventario_cosa_registros", ["inventario_cosa_id"], name: "index_inventario_cosa_registros_on_inventario_cosa_id", using: :btree

  create_table "inventario_cosas", force: :cascade do |t|
    t.integer  "cosa_id"
    t.integer  "inventario"
    t.integer  "cantidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "inventario_cosas", ["cosa_id"], name: "index_inventario_cosas_on_cosa_id", using: :btree
  add_index "inventario_cosas", ["inventario", "cosa_id"], name: "index_inventario_cosas_on_inventario_and_cosa_id", unique: true, using: :btree

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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "mensaje"
    t.string   "forma_pago",             default: "T"
    t.text     "instrucciones_entrega"
    t.string   "sector_entrega"
    t.text     "de"
    t.text     "para"
    t.string   "horario_entrega"
    t.string   "punto_entrega"
    t.boolean  "con_tapa_personalizada", default: false
    t.string   "paypal_tx"
  end

  create_table "producto_cosas", force: :cascade do |t|
    t.integer  "cosa_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "producto_cosas", ["cosa_id"], name: "index_producto_cosas_on_cosa_id", using: :btree
  add_index "producto_cosas", ["producto_id"], name: "index_producto_cosas_on_producto_id", using: :btree

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "foto_url"
    t.decimal  "precio"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "orden",            default: 10000
    t.string   "ciudadesMismoDia", default: "UIO"
    t.integer  "empaque_id"
  end

  add_index "productos", ["empaque_id"], name: "index_productos_on_empaque_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tapas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "url"
    t.string   "categoria"
    t.string   "descripcion"
    t.string   "variables"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empaque_id"
  end

  add_index "tapas", ["empaque_id"], name: "index_tapas_on_empaque_id", using: :btree

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
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fecha_nacimiento"
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true, using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "categoria_productos", "categoria"
  add_foreign_key "categoria_productos", "productos"
  add_foreign_key "fotos", "productos"
  add_foreign_key "inventario_cosa_registros", "inventario_cosas"
  add_foreign_key "inventario_cosas", "cosas"
  add_foreign_key "producto_cosas", "cosas"
  add_foreign_key "producto_cosas", "productos"
  add_foreign_key "productos", "empaques"
  add_foreign_key "tapas", "empaques"
end
