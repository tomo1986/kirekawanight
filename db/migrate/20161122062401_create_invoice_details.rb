class CreateInvoiceDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_details do |t|
      t.references :invoice,          index: true
      t.string :name,                 null: false, default: ""
      t.integer :quantilty,           null: false, default: 1
      t.integer :unit_price,          null: false, default: 0
      t.timestamps
    end
  end
end
