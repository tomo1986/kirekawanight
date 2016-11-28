class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information do |t|
      t.references :group, index: true
      t.string :content
      t.string :watchword
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :is_displayed
      t.timestamps
    end
  end
end
