class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :group, index: true
      t.string :name, default:''
      t.string :nick_name, default:''
      t.string :birthplace, default:''
      t.string :residence, default:''
      t.datetime :birthday
      t.string :constellation, default:''
      t.string :job_type, default:''
      t.string :blood_type, default:''
      t.string :sex, default:''
      t.string :sns_line, default:''
      t.string :sns_zalo, default:''
      t.string :sns_wechat, default:''
      t.string :height, default:''
      t.string :weight, default:''
      t.string :bust, default:''
      t.string :bust_size, default:''
      t.string :waist, default:''
      t.string :hip, default:''
      t.boolean :is_japanese, default: nil, index: true
      t.boolean :is_english, default: nil, index: true
      t.boolean :is_chinese, default: nil, index: true
      t.boolean :is_korean, default: nil, index: true
      t.datetime :deleted_at
      t.datetime :stopped_at
      t.timestamps
    end
  end
end
