class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :workspaces
  has_and_belongs_to_many :items

  validates :name, presence: true, length: {minimum: 3}
  validates_uniqueness_of :email
end
