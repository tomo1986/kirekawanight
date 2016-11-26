class AddTelCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :tel, :string
    add_column :customers, :sns_line, :string
    add_column :customers, :sns_zalo, :string
    add_column :customers, :sns_wechat, :string
  end
end
