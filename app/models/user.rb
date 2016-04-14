class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :validatable, :confirmable
  validates :name, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /\A[a-z0-9_-]+\z/i }

  has_many :todo_apps, dependent: :destroy

  before_save do
    self.email.downcase!
  end

  def to_param
    name
  end

end
