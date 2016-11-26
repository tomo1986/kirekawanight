class AddTotalScoreReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :total_score, :float
  end
end
