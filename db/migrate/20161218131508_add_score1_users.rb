class AddScore1Users < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :score1, :float
    add_column :users, :score2, :float
    add_column :users, :score3, :float
    add_column :users, :score4, :float
    add_column :users, :score5, :float
    add_column :users, :total_score, :float
  end
end
