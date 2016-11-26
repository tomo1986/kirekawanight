class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :type
      t.string :subject_type
      t.string :subject_id
      t.string :name
      t.string :tel
      t.string :email
      t.string :sns_line
      t.string :sns_zalo
      t.string :sns_wechat
      t.text :message
      t.timestamps
    end
  end
end
