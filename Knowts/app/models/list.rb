class List < ActiveRecord::Base
  #destroy the item upon deleting the list
  has_many :items, dependent: :destroy
  belongs_to :workspace

  validates :name, presence: true, length: {minimum: 3}
end
