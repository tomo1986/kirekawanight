class AddAuthenticationCodeShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :authentication_code, :string
  end
end
