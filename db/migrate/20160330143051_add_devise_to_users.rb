class AddDeviseToUsers < ActiveRecord::Migration

  def change
    change_table(:users) do |t|
      # database authenticatable
      t.string :encrypted_password, null: false, default: ""

      # recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # rememberable
      t.datetime :remember_created_at

      # confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      # old columns
      t.remove :password_digest
    end

    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end

end
