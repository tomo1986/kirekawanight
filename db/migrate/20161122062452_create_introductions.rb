class CreateIntroductions < ActiveRecord::Migration[5.0]
  def change
    create_table :introductions do |t|
      t.references :group,      index: true
      t.integer :people
      t.text :note
      t.datetime :introduction_date

      t.timestamps
    end
  end
end
