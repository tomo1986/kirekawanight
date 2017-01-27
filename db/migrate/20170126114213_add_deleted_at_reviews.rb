class AddDeletedAtReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :deleted_at, :datetime
  end
end
