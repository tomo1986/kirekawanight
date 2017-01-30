class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :type
      t.string :shop_id
      t.string :title
      t.string :sub_title
      t.integer :price
      t.integer :sort_no
      t.timestamps
    end
  end
end
