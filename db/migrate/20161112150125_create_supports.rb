class CreateSupports < ActiveRecord::Migration[5.0]
  def change
    create_table :supports do |t|
      t.string :type
      t.string :subject_type
      t.string :subject_id
      t.timestamps
    end
  end
end
