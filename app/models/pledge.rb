class Pledge < ActiveRecord::Base

  validates :task_id, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 2 }

  belongs_to :user

  def self.process_all

  end

end
