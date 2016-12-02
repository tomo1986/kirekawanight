class AddNameKanaShops < ActiveRecord::Migration[5.0]
  def change

    add_column :shops, :name_kana, :string
    add_column :shops, :is_smoked, :boolean
    add_column :shops, :opened_at, :datetime
    add_column :shops, :closed_at, :datetime
    add_column :shops, :is_card, :boolean
    add_column :shops, :girls_count, :integer
    add_column :shops, :budget_yen, :integer
    add_column :shops, :budget_vnd, :integer
    add_column :shops, :budget_usd, :integer
    add_column :shops, :service, :text
    add_column :shops, :score, :float
    add_column :shops, :broker_id, :integer
    add_column :shops, :tip, :string
  end
end
