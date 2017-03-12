class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :type
      t.string :subject_type
      t.integer :subject_id, index: true
      t.string :description
      t.string :sub_description
      t.datetime :started_at, null: false
      t.datetime :end_at
      t.boolean :is_displayed, default: true, null: false
      t.integer :sort_no
      t.timestamps
    end
  end
end
