class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :type
      t.string :subject_type
      t.integer :subject_id, index: true
      t.text :script
      t.string :account
      t.string :password
      t.boolean :is_displayed, default: nil, index: true
      t.timestamps
    end
  end
end
