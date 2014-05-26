class Item < ActiveRecord::Base
  has_and_belongs_to_many :users
  #destroy the item upon deleting the list
  belongs_to :list, dependent: :destroy

  validates :due, presence: true
  validates :content, presence: true, length: {within: 3..150}
end
