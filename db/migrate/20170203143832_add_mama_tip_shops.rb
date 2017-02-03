class AddMamaTipShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :mama_tip, :boolean
    add_column :shops, :charge, :boolean
    add_column :shops, :karaoke_machine, :boolean
    add_column :shops, :one_point, :string
    add_column :users, :one_point, :string
  end
end
