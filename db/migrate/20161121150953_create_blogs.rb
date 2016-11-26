class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :type
      t.integer :sender_id, index: true
      t.string :sender_type
      t.string :head_title_ja
      t.string :head_title_vn
      t.string :head_title_en
      t.string :head_keyword_ja
      t.string :head_keyword_vn
      t.string :head_keyword_en
      t.string :head_description_ja
      t.string :head_description_vn
      t.string :head_description_en
      t.string :title_ja
      t.string :title_vn
      t.string :title_en
      t.text   :article_ja
      t.text   :article_vn
      t.text   :article_en
      t.timestamps
    end
  end
end
