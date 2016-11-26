class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :receiver_id, index: true
      t.string :receiver_type
      t.integer :service_score
      t.integer :serving_score
      t.integer :girl_score
      t.integer :ambience_score
      t.integer :again_score
      t.text :comment
      t.boolean :is_displayed
      t.datetime :repaired_at
      t.timestamps
    end
  end
end
