class AddOpinionReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :opinion, :text
    add_column :shops, :score1, :float
    add_column :shops, :score2, :float
    add_column :shops, :score3, :float
    add_column :shops, :score4, :float
    add_column :shops, :score5, :float
    add_column :shops, :total_score, :float
    remove_column :shops, :score, :float
  end
end
