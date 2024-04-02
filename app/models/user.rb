class User < ApplicationRecord
  attr_accessor :token
  
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
