class User < ActiveRecord::Base

  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, length: { maximum: 255 }

end
