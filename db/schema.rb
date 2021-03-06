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

ActiveRecord::Schema.define(version: 20170414083455) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "banners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.string   "subject_id"
    t.string   "integer"
    t.string   "title"
    t.string   "link"
    t.boolean  "is_target_blank"
    t.text     "article",         limit: 65535
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["subject_id", "subject_type"], name: "index_banners_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_banners_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "blogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "head_title_ja"
    t.string   "head_title_vn"
    t.string   "head_title_en"
    t.string   "head_keyword_ja"
    t.string   "head_keyword_vn"
    t.string   "head_keyword_en"
    t.string   "head_description_ja"
    t.string   "head_description_vn"
    t.string   "head_description_en"
    t.string   "title_ja"
    t.string   "title_vn"
    t.string   "title_en"
    t.text     "article_ja",          limit: 65535
    t.text     "article_vn",          limit: 65535
    t.text     "article_en",          limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "subject_type"
    t.integer  "subject_id"
  end

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "shop_id"], name: "index_cards_on_type_and_shop_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.string   "subject_id"
    t.string   "name"
    t.string   "tel"
    t.string   "email"
    t.string   "sns_line"
    t.string   "sns_zalo"
    t.string   "sns_wechat"
    t.text     "message",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "return_way"
    t.index ["subject_id", "subject_type"], name: "index_contacts_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_contacts_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "description"
    t.string   "sub_description"
    t.datetime "started_at",                     null: false
    t.datetime "end_at"
    t.boolean  "is_displayed",    default: true, null: false
    t.integer  "sort_no"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["subject_id", "subject_type"], name: "index_coupons_on_subject_id_and_subject_type", using: :btree
    t.index ["subject_id"], name: "index_coupons_on_subject_id", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_coupons_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "tel"
    t.string   "sns_line"
    t.string   "sns_zalo"
    t.string   "sns_wechat"
    t.datetime "birthday"
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "discounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "groups"
    t.integer  "peoples"
    t.integer  "price"
    t.string   "content"
    t.string   "watchword"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "tel"
    t.boolean  "is_displayed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "subject_type"
    t.string   "subject_id"
    t.index ["subject_id", "subject_type"], name: "index_discounts_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_discounts_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "title"
    t.string   "sub_title"
    t.text     "description",  limit: 4294967295
    t.datetime "started_at",                                     null: false
    t.datetime "end_at"
    t.boolean  "is_displayed",                    default: true, null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["subject_id", "subject_type"], name: "index_events_on_subject_id_and_subject_type", using: :btree
    t.index ["subject_id"], name: "index_events_on_subject_id", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_events_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "job_type",                             default: ""
    t.string   "tel",                                  default: ""
    t.string   "sns_line",                             default: ""
    t.string   "sns_zalo",                             default: ""
    t.string   "sns_wechat",                           default: ""
    t.string   "address",                              default: ""
    t.string   "lat",                                  default: ""
    t.string   "lon",                                  default: ""
    t.text     "interview_ja",           limit: 65535
    t.text     "interview_vn",           limit: 65535
    t.text     "interview_en",           limit: 65535
    t.boolean  "is_credit"
    t.boolean  "is_japanese"
    t.boolean  "is_english"
    t.boolean  "is_chinese"
    t.boolean  "is_korean"
    t.datetime "deleted_at"
    t.datetime "stopped_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "broker_id"
    t.string   "chip"
    t.text     "note",                   limit: 65535
    t.text     "payment_sql",            limit: 65535
    t.float    "score",                  limit: 24
    t.boolean  "is_smoked"
    t.integer  "girls_count"
    t.string   "name_kana"
    t.integer  "budget_yen"
    t.integer  "budget_vnd"
    t.integer  "budget_usd"
    t.text     "service",                limit: 65535
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.index ["email"], name: "index_groups_on_email", unique: true, using: :btree
    t.index ["is_chinese"], name: "index_groups_on_is_chinese", using: :btree
    t.index ["is_credit"], name: "index_groups_on_is_credit", using: :btree
    t.index ["is_english"], name: "index_groups_on_is_english", using: :btree
    t.index ["is_japanese"], name: "index_groups_on_is_japanese", using: :btree
    t.index ["is_korean"], name: "index_groups_on_is_korean", using: :btree
    t.index ["reset_password_token"], name: "index_groups_on_reset_password_token", unique: true, using: :btree
  end

  create_table "guides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "users_id"
    t.text     "message",    limit: 65535
    t.integer  "price"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["users_id"], name: "index_guides_on_users_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "dimensions"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "deleted_at"
    t.index ["subject_id"], name: "index_images_on_subject_id", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_images_on_type_and_subject_id_and_subject_type", using: :btree
    t.index ["type"], name: "index_images_on_type", using: :btree
  end

  create_table "information", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "group_id"
    t.string   "content"
    t.string   "watchword"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "is_displayed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["group_id"], name: "index_information_on_group_id", using: :btree
  end

  create_table "introductions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "group_id"
    t.integer  "people"
    t.text     "note",              limit: 65535
    t.datetime "introduction_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["group_id"], name: "index_introductions_on_group_id", using: :btree
  end

  create_table "invoice_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "invoice_id"
    t.string   "name",       default: "", null: false
    t.integer  "quantilty",  default: 1,  null: false
    t.integer  "unit_price", default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "category"
    t.integer  "tax_rate"
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id", using: :btree
  end

  create_table "invoices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "total",                         default: 0, null: false
    t.datetime "period_from"
    t.datetime "period_to"
    t.datetime "due_date"
    t.datetime "issued_at"
    t.datetime "paid_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "shop_id"
    t.integer  "sub_amount"
    t.integer  "transfer_amount"
    t.string   "sales_person"
    t.text     "note",            limit: 65535
    t.integer  "admin_id"
    t.index ["shop_id"], name: "index_invoices_on_shop_id", using: :btree
  end

  create_table "media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.text     "script",       limit: 65535
    t.string   "account"
    t.string   "password"
    t.boolean  "is_displayed"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["is_displayed"], name: "index_media_on_is_displayed", using: :btree
    t.index ["subject_id", "subject_type"], name: "index_media_on_subject_id_and_subject_type", using: :btree
    t.index ["subject_id"], name: "index_media_on_subject_id", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_media_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "shop_id"
    t.string   "title"
    t.string   "sub_title"
    t.integer  "price"
    t.integer  "sort_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "shop_id"], name: "index_menus_on_type_and_shop_id", using: :btree
  end

  create_table "page_views", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.string   "subject_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id", "subject_type"], name: "index_page_views_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_page_views_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "pickups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.string   "subject_id"
    t.integer  "price"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "number_place"
    t.integer  "quantilty"
    t.index ["subject_id", "subject_type"], name: "index_pickups_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_pickups_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "price"
    t.integer  "maximum_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.text     "note",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["receiver_id"], name: "index_posts_on_receiver_id", using: :btree
    t.index ["sender_id"], name: "index_posts_on_sender_id", using: :btree
    t.index ["type", "receiver_id", "receiver_type"], name: "index_posts_on_type_and_receiver_id_and_receiver_type", using: :btree
    t.index ["type", "sender_id", "sender_type"], name: "index_posts_on_type_and_sender_id_and_sender_type", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.text     "comment",       limit: 65535
    t.boolean  "is_displayed"
    t.datetime "repaired_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "total_score",   limit: 24
    t.string   "title"
    t.string   "info1"
    t.string   "info2"
    t.string   "info3"
    t.string   "info4"
    t.string   "info5"
    t.integer  "score1"
    t.integer  "score2"
    t.integer  "score3"
    t.integer  "score4"
    t.integer  "score5"
    t.boolean  "is_draft"
    t.text     "opinion",       limit: 65535
    t.datetime "deleted_at"
    t.index ["receiver_id"], name: "index_reviews_on_receiver_id", using: :btree
    t.index ["sender_id"], name: "index_reviews_on_sender_id", using: :btree
    t.index ["type", "receiver_id", "receiver_type"], name: "index_reviews_on_type_and_receiver_id_and_receiver_type", using: :btree
    t.index ["type", "sender_id", "sender_type"], name: "index_reviews_on_type_and_sender_id_and_sender_type", using: :btree
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email",                                     default: "",    null: false
    t.string   "encrypted_password",                        default: "",    null: false
    t.integer  "group_id"
    t.string   "job_type",                                  default: ""
    t.string   "tel",                                       default: ""
    t.integer  "min_budget"
    t.integer  "max_budget"
    t.string   "sns_line",                                  default: ""
    t.string   "sns_zalo",                                  default: ""
    t.string   "sns_wechat",                                default: ""
    t.string   "address",                                   default: ""
    t.string   "lat",                                       default: ""
    t.string   "lon",                                       default: ""
    t.text     "interview_ja",           limit: 4294967295
    t.text     "interview_vn",           limit: 65535
    t.text     "interview_en",           limit: 65535
    t.boolean  "is_credit"
    t.boolean  "is_japanese"
    t.boolean  "is_english"
    t.boolean  "is_chinese"
    t.boolean  "is_korean"
    t.datetime "deleted_at"
    t.datetime "stopped_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "name_kana"
    t.boolean  "is_smoked"
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.boolean  "is_card"
    t.integer  "girls_count"
    t.integer  "budget_yen"
    t.integer  "budget_vnd"
    t.integer  "budget_usd"
    t.text     "service",                limit: 65535
    t.integer  "broker_id"
    t.string   "tip"
    t.float    "score1",                 limit: 24
    t.float    "score2",                 limit: 24
    t.float    "score3",                 limit: 24
    t.float    "score4",                 limit: 24
    t.float    "score5",                 limit: 24
    t.float    "total_score",            limit: 24
    t.text     "invoice_sql",            limit: 65535
    t.integer  "room_count"
    t.integer  "seat_count"
    t.integer  "ranking"
    t.string   "authentication_code"
    t.integer  "admin_id"
    t.string   "contract_person"
    t.text     "catch_copy",             limit: 65535
    t.string   "access"
    t.integer  "tip_avg"
    t.boolean  "mama_tip"
    t.boolean  "charge"
    t.boolean  "karaoke_machine"
    t.string   "one_point"
    t.string   "contract_person2"
    t.string   "tel2"
    t.string   "write_adress"
    t.boolean  "is_displayed_phone",                        default: false
    t.datetime "fee_at"
    t.text     "note",                   limit: 65535
    t.index ["admin_id"], name: "index_shops_on_admin_id", using: :btree
    t.index ["email"], name: "index_shops_on_email", unique: true, using: :btree
    t.index ["group_id"], name: "index_shops_on_group_id", using: :btree
    t.index ["is_chinese"], name: "index_shops_on_is_chinese", using: :btree
    t.index ["is_credit"], name: "index_shops_on_is_credit", using: :btree
    t.index ["is_english"], name: "index_shops_on_is_english", using: :btree
    t.index ["is_japanese"], name: "index_shops_on_is_japanese", using: :btree
    t.index ["is_korean"], name: "index_shops_on_is_korean", using: :btree
    t.index ["reset_password_token"], name: "index_shops_on_reset_password_token", unique: true, using: :btree
  end

  create_table "supports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "subject_type"
    t.string   "subject_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id", "subject_type"], name: "index_supports_on_subject_id_and_subject_type", using: :btree
    t.index ["type", "subject_id", "subject_type"], name: "index_supports_on_type_and_subject_id_and_subject_type", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "type",                          default: ""
    t.text     "my_color",        limit: 65535
    t.text     "happy_word",      limit: 65535
    t.text     "gesture",         limit: 65535
    t.text     "attracted",       limit: 65535
    t.text     "love_situation",  limit: 65535
    t.text     "first_love",      limit: 65535
    t.text     "how_to_approach", limit: 65535
    t.text     "how_to_holiday",  limit: 65535
    t.text     "idea_couple",     limit: 65535
    t.text     "take_one",        limit: 65535
    t.text     "like_boy",        limit: 65535
    t.text     "like_girl",       limit: 65535
    t.text     "like_word",       limit: 65535
    t.text     "like_music",      limit: 65535
    t.text     "like_movie",      limit: 65535
    t.text     "like_place",      limit: 65535
    t.text     "like_food",       limit: 65535
    t.text     "like_drink",      limit: 65535
    t.text     "like_sports",     limit: 65535
    t.text     "best_feature",    limit: 65535
    t.text     "love_tips",       limit: 65535
    t.text     "character",       limit: 65535
    t.text     "hobby",           limit: 65535
    t.text     "skill",           limit: 65535
    t.text     "habit",           limit: 65535
    t.text     "brag",            limit: 65535
    t.text     "my_fad",          limit: 65535
    t.text     "secret_talk",     limit: 65535
    t.text     "born_again",      limit: 65535
    t.text     "dream",           limit: 65535
    t.text     "go",              limit: 65535
    t.text     "want",            limit: 65535
    t.text     "do_something",    limit: 65535
    t.text     "happy_event",     limit: 65535
    t.text     "painful_event",   limit: 65535
    t.text     "previous_life",   limit: 65535
    t.text     "admire_person",   limit: 65535
    t.text     "interview",       limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["type", "user_id"], name: "index_user_profiles_on_type_and_user_id", using: :btree
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                         default: ""
    t.string   "nick_name",                    default: ""
    t.string   "birthplace",                   default: ""
    t.string   "residence",                    default: ""
    t.datetime "birthday"
    t.string   "constellation",                default: ""
    t.string   "job_type",                     default: ""
    t.string   "blood_type",                   default: ""
    t.string   "sex",                          default: ""
    t.string   "sns_line",                     default: ""
    t.string   "sns_zalo",                     default: ""
    t.string   "sns_wechat",                   default: ""
    t.string   "height",                       default: ""
    t.string   "weight",                       default: ""
    t.string   "bust",                         default: ""
    t.string   "bust_size",                    default: ""
    t.string   "waist",                        default: ""
    t.string   "hip",                          default: ""
    t.boolean  "is_japanese"
    t.boolean  "is_english"
    t.boolean  "is_chinese"
    t.boolean  "is_korean"
    t.datetime "deleted_at"
    t.datetime "stopped_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "note",           limit: 65535
    t.text     "payment_sql",    limit: 65535
    t.float    "score",          limit: 24
    t.integer  "shop_id"
    t.boolean  "can_guided"
    t.string   "japanese_level"
    t.float    "score1",         limit: 24
    t.float    "score2",         limit: 24
    t.float    "score3",         limit: 24
    t.float    "score4",         limit: 24
    t.float    "score5",         limit: 24
    t.float    "total_score",    limit: 24
    t.integer  "ranking"
    t.string   "one_point"
    t.boolean  "is_pickuped"
    t.index ["is_chinese"], name: "index_users_on_is_chinese", using: :btree
    t.index ["is_english"], name: "index_users_on_is_english", using: :btree
    t.index ["is_japanese"], name: "index_users_on_is_japanese", using: :btree
    t.index ["is_korean"], name: "index_users_on_is_korean", using: :btree
    t.index ["shop_id"], name: "index_users_on_shop_id", using: :btree
  end

end
