class Pledge < ActiveRecord::Base

  validates :task_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

end
