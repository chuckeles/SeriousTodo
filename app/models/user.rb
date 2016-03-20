class User < ActiveRecord::Base

  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_save do
    self.email = email.downcase
  end

end
