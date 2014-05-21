class Item < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :list

  validates :due, presence: true
  validates :content, presence: true, length: {within: 3..150}
end
