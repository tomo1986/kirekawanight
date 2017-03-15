class AddIsDisplayedPhoneShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :is_displayed_phone, :boolean, default: false
  end
end
