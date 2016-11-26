class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :type
      t.string :name
      t.integer :price
      t.integer :maximum_count
      t.timestamps
    end
  end
end
