class Pledge < ActiveRecord::Base

  validates :task_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal: 2 }

end
