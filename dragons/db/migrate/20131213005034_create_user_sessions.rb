class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.integer :user_id
      t.string :session_token
      t.string :environment
      t.string :geo

      t.timestamps
    end

    add_index :user_sessions, :user_id
    add_index :user_sessions, :session_token
  end
end
