class CreatePageViews < ActiveRecord::Migration[5.0]
  def change
    create_table :page_views do |t|
      t.string :type
      t.string :subject_type
      t.string :subject_id
      t.timestamps
    end
  end
end
