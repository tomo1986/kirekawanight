class RemoveClosedAtFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :opened_at, :string
    remove_column :groups, :closed_at, :string
    add_column :groups, :opened_at, :datetime
    add_column :groups, :closed_at, :datetime

  end
end
