class AddConstraintsToUserSessions < ActiveRecord::Migration
  def change
    change_column :user_sessions, :user_id, :integer, null: false
    change_column :user_sessions, :session_token, :string, null: false
    change_column :user_sessions, :environment, :string, null: false
    change_column :user_sessions, :geo, :string, null: false
  end
end
