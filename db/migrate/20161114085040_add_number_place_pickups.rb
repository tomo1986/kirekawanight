class AddNumberPlacePickups < ActiveRecord::Migration[5.0]
  def change
    add_column :pickups, :number_place, :integer
  end
end
