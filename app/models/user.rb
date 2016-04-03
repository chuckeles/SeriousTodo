class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :validatable, :confirmable
  validates :name, presence: true, uniqueness: true

  before_save do
    self.email.downcase!
  end

  def to_param
    name
  end

end
