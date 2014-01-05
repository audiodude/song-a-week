class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :websites

  validates_associated :websites, message: 'One or more of the given websites was invalid'
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates(
      :username,
      presence: true,
      uniqueness: true,
      length: { 
        maximum: 20
      }, format: {
        with: /\A[a-zA-Z0-9_-]+\z/,
        message: "only allows letters, numbers, and '_-'"
  })
  validates :name, presence: true, length: { maximum: 40 }
  validates :application, length: { minimum: 50, maximum: 1000 }

  self.per_page = 10

  def save_reset_token!
    self.reset_token = SecureRandom.urlsafe_base64(nil, false)
    save!
  end
end
