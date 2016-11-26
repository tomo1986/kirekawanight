class RemoveOpenedAtFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :opened_at, :datetime
    remove_column :groups, :closed_at, :datetime
    add_column :groups, :opened_at, :string
    add_column :groups, :closed_at, :string

  end
end
