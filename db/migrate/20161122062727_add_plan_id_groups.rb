class AddPlanIdGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :broker_id, :integer
    add_column :groups, :chip, :string
    add_column :groups, :note, :text
    add_column :groups, :payment_sql, :text
  end
end
