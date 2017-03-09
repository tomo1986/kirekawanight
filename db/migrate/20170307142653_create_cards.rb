class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :type
      t.string :shop_id
      t.timestamps
    end
  end
end
