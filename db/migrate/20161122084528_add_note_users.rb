class AddNoteUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :note, :text
    add_column :users, :payment_sql, :text

  end
end
