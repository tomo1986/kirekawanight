class DeviseCreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      ## Database authenticatable
      t.string :name
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.references :group, index: true
      t.string :job_type, default:''
      t.string :tel, default:''
      t.integer :min_budget
      t.integer :max_budget
      t.string :sns_line, default:''
      t.string :sns_zalo, default:''
      t.string :sns_wechat, default:''
      t.string :address, default:''
      t.string :lat, default:''
      t.string :lon, default:''
      t.text   :interview_ja
      t.text   :interview_vn
      t.text   :interview_en
      t.boolean :is_credit, default: nil, index: true
      t.boolean :is_japanese, default: nil, index: true
      t.boolean :is_english, default: nil, index: true
      t.boolean :is_chinese, default: nil, index: true
      t.boolean :is_korean, default: nil, index: true
      t.datetime :deleted_at
      t.datetime :stopped_at

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :shops, :email,                unique: true
    add_index :shops, :reset_password_token, unique: true
    # add_index :shops, :confirmation_token,   unique: true
    # add_index :shops, :unlock_token,         unique: true
  end
end
