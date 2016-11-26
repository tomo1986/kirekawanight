class AddReturnWayContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :return_way, :string
  end
end
