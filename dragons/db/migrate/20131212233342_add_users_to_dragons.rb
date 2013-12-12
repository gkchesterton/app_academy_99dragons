class AddUsersToDragons < ActiveRecord::Migration
  def change
    add_column :dragons, :user_id, :integer, null: false, default: 1
    add_index :dragons, :user_id
  end
end


