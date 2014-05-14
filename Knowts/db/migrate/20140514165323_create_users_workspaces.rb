class CreateUsersWorkspaces < ActiveRecord::Migration
  def change
    create_table :users_workspaces, id:false do |t|
      t.integer :user_id
      t.integer :workspace_id
    end
  end
end
