class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :validatable

  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true

  before_save do
    self.email.downcase!
  end

  def to_param
    name
  end

end
