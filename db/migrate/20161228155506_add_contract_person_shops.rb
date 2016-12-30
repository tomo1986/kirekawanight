class AddContractPersonShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :contract_person, :string
  end
end
