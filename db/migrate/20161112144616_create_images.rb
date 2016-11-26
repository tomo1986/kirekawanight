class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :type, index:true
      t.integer :subject_id, index: true
      t.string :subject_type
      t.string :dimensions
      t.has_attached_file :image
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :images, [:type, :subject_id, :subject_type]
  end
end
