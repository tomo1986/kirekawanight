class AddIndex < ActiveRecord::Migration
  def change

    #users
    add_index :users, :shop_id

    #users
    add_index :user_profiles, [:type,:user_id]

    #invoices
    add_index :invoices, :shop_id

    #banners
    add_index :banners, [:type,:subject_id, :subject_type]
    add_index :banners, [:subject_id, :subject_type]

    #blogs
    add_index :contacts, [:type,:subject_id, :subject_type]
    add_index :contacts, [:subject_id, :subject_type]


    #discounts
    add_index :discounts, [:type,:subject_id, :subject_type]
    add_index :discounts, [:subject_id, :subject_type]

    #cards
    add_index :cards, [:type, :shop_id]


    #coupons
    add_index :coupons, [:type,:subject_id, :subject_type]
    add_index :coupons, [:subject_id, :subject_type]

    #events
    add_index :events, [:type,:subject_id, :subject_type]
    add_index :events, [:subject_id, :subject_type]



    #medias
    add_index :media, [:type,:subject_id, :subject_type]
    add_index :media, [:subject_id, :subject_type]

    #menus
    add_index :menus, [:type, :shop_id]

    #page_views
    add_index :page_views, [:type,:subject_id, :subject_type]
    add_index :page_views, [:subject_id, :subject_type]

    #pickups
    add_index :pickups, [:type,:subject_id, :subject_type]
    add_index :pickups, [:subject_id, :subject_type]

    #supports
    add_index :supports, [:type,:subject_id, :subject_type]
    add_index :supports, [:subject_id, :subject_type]

    #posts
    add_index :posts, [:type,:sender_id, :sender_type]
    add_index :posts, [:type,:receiver_id, :receiver_type]

    #reviews
    add_index :reviews, [:type,:sender_id, :sender_type]
    add_index :reviews, [:type,:receiver_id, :receiver_type]

  end
end
