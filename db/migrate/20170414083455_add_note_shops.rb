class AddNoteShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :fee_at, :datetime
    add_column :shops, :note, :text
  end
end
