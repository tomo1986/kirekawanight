class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.string :type
      t.string :subject_type
      t.string :subject_id, :integer
      t.string :title
      t.string :link
      t.boolean :is_target_blank
      t.text :article
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
