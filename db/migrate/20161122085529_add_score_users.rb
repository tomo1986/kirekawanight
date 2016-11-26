class AddScoreUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :score, :float
  end
end
