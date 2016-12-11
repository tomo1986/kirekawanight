class AddBirthdayCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :birthday, :datetime
  end
end
