class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.integer :receiver_id, index: true
      t.string :receiver_type
      t.text :note
      t.timestamps
    end
  end
end
