class AddWorkspaceIdToLists < ActiveRecord::Migration
  def change
    add_column :lists, :workspace_id, :integer
  end
end
