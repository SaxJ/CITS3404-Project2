class AddOwnerToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :owner, :integer
  end
end
