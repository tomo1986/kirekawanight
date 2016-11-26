class AddSubjectIdBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :subject_type, :string
    add_column :blogs, :subject_id, :integer
    remove_column :blogs, :sender_type, :string
    remove_column :blogs, :sender_id, :integer
  end
end
