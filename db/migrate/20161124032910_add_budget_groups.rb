class AddBudgetGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :min_budget_yen, :integer
    remove_column :groups, :max_budget_yen, :integer
    remove_column :groups, :min_budget_vnd, :integer
    remove_column :groups, :max_budget_vnd, :integer
    remove_column :groups, :min_budget_usd, :integer
    remove_column :groups, :max_budget_usd, :integer
    remove_column :groups, :is_card, :boolean

    add_column :groups, :budget_yen, :integer
    add_column :groups, :budget_vnd, :integer
    add_column :groups, :budget_usd, :integer
  end
end
