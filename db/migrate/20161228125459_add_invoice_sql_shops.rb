class AddInvoiceSqlShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :invoice_sql, :text
    add_column :shops, :room_count, :integer
    add_column :shops, :seat_count, :integer
    add_column :invoice_details, :category, :string
    add_column :invoice_details, :tax_rate, :integer
    add_column :shops, :admin_id, :integer
    add_index :shops, :admin_id
    add_column :invoices, :sub_amount, :integer
    add_column :invoices, :transfer_amount, :integer
    add_column :invoices, :sales_person, :string
    add_column :invoices, :note, :text
    add_column :invoices, :admin_id, :integer
    add_index :invoices, :admin_id
    add_column :users, :can_make_love, :boolean
  end
end
