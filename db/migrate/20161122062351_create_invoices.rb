class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :group,      index: true
      t.integer :total,     null: false, default: 0
      t.datetime :period_from
      t.datetime :period_to
      t.datetime :due_date
      t.datetime :issued_at
      t.datetime :paid_at
      t.timestamps
    end
  end
end
