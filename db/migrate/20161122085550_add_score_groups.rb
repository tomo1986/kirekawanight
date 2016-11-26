class AddScoreGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :score, :float
  end
end
