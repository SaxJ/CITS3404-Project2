class Workspace < ActiveRecord::Base
  has_and_belongs_to_many :users
  before_destroy { users.clear }
  #destroy the list upon deleting the workspaces
  has_many :lists, dependent: :destroy

  validates :name, presence: true
end
