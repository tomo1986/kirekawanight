class AddServiceGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :service, :text
  end
end
