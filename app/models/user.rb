class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :websites

  validates_associated :websites, message: 'One or more of the given websites was invalid'
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :application, length: { minimum: 50 }
end
