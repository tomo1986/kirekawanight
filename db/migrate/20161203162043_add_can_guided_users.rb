class AddCanGuidedUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :can_guided, :boolean
    add_column :users, :japanese_level, :string
  end
end
