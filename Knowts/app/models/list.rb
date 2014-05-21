class List < ActiveRecord::Base
  has_many :items
  belongs_to :workspace

  validates :name, presence: true, length: {minimum: 3}
end
