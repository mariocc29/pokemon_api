class CreateUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true, name: 'users_username_idx'
  end

  def down
    drop_table :users
  end
end
