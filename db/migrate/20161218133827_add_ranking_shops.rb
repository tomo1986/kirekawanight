class AddRankingShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :ranking, :integer
    add_column :users, :ranking, :integer
  end
end
