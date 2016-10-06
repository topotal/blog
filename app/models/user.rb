class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :entries
  has_secure_password
end
