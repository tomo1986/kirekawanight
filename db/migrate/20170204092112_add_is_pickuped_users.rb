class AddIsPickupedUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_pickuped, :boolean
  end
end
