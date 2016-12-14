class AddInfo1Reviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :info1, :string
    add_column :reviews, :info2, :string
    add_column :reviews, :info3, :string
    add_column :reviews, :info4, :string
    add_column :reviews, :info5, :string

    add_column :reviews, :score1, :integer
    add_column :reviews, :score2, :integer
    add_column :reviews, :score3, :integer
    add_column :reviews, :score4, :integer
    add_column :reviews, :score5, :integer
    add_column :reviews, :is_draft, :boolean

    remove_column :reviews, :service_score, :integer
    remove_column :reviews, :serving_score, :integer
    remove_column :reviews, :girl_score, :integer
    remove_column :reviews, :ambience_score, :integer
    remove_column :reviews, :again_score, :integer
  end
end
