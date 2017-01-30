class AddCatchCopyShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :catch_copy, :text
    add_column :shops, :access, :string
    add_column :shops, :tip_avg, :integer
  end
end
