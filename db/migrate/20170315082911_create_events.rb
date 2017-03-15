class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :type
      t.string :subject_type
      t.integer :subject_id, index: true
      t.string :title
      t.string :sub_title
      t.text :description
      t.datetime :started_at, null: false
      t.datetime :end_at
      t.boolean :is_displayed, default: true, null: false
      t.timestamps
    end
  end
end
