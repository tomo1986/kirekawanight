class AddWriteAdressShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :contract_person2, :string
    add_column :shops, :tel2, :string
    add_column :shops, :write_adress, :string
  end
end
