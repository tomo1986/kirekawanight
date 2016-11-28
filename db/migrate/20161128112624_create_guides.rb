class CreateGuides < ActiveRecord::Migration[5.0]
  def change
    create_table :guides do |t|
      t.references :users, index: true
      t.text :message
      t.integer :price
      t.timestamps
    end
  end
end
