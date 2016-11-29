class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.references :group, index: true
      t.string :type
      t.integer :groups
      t.integer :peoples
      t.integer :price
      t.string :content
      t.string :watchword
      t.datetime :start_at
      t.datetime :end_at
      t.string :tel
      t.boolean :is_displayed
      t.timestamps
    end
  end
end
