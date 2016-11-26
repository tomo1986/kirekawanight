class AddSmokingGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :min_budget, :integer
    remove_column :groups, :max_budget, :integer
    add_column :groups, :is_smoked, :boolean
    add_column :groups, :opened_at, :datetime
    add_column :groups, :closed_at, :datetime
    add_column :groups, :is_card, :boolean
    add_column :groups, :girls_count, :integer
    add_column :groups, :name_kana, :string
    add_column :groups, :min_budget_yen, :integer
    add_column :groups, :max_budget_yen, :integer
    add_column :groups, :min_budget_vnd, :integer
    add_column :groups, :max_budget_vnd, :integer
    add_column :groups, :min_budget_usd, :integer
    add_column :groups, :max_budget_usd, :integer

  end
end
