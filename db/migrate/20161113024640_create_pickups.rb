class CreatePickups < ActiveRecord::Migration[5.0]
  def change
    create_table :pickups do |t|
      t.string :type
      t.string :subject_type
      t.string :subject_id
      t.integer :price
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
