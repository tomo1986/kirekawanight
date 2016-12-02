class RemoveGroupIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :group_id, :integer
    add_column :users, :shop_id, :integer

    remove_column :discounts, :group_id, :integer
    add_column :discounts, :subject_type, :string
    add_column :discounts, :subject_id, :string

    remove_column :invoices, :group_id, :integer
    add_column :invoices, :shop_id, :integer


  end
end
