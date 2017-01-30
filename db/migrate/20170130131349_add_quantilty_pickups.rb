class AddQuantiltyPickups < ActiveRecord::Migration[5.0]
  def change
    add_column :pickups, :quantilty, :integer
  end
end
