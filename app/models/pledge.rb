require_relative "../utilities/todoist"

class Pledge < ActiveRecord::Base

  validates :task_id, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 2 }

  belongs_to :user

  def self.process_all
    success_count = 0
    fail_count = 0

    tasks = {}
    all.each do |pledge|
      unless tasks[pledge.user_id]
        tasks[pledge.user_id] = {}
        items = Todoist.items(User.find(pledge.user_id), {})
        items.each do |item|
          tasks[pledge.user_id][item[:id]] = item
        end
      end

      p tasks
      if not tasks[pledge.user_id][pledge.task_id]
        # Pledge.delete(pledge.id)
        success_count += 1
        p "Pledge #{pledge.id} deleted, the task is complete."
      elsif tasks[pledges.user_id][pledge.task_id][:due] < DateTime.now
        fail_count += 1
        p "Task #{tasks[pledge.user_id][pledge.task_id][:content]} overdue! Charge the user!!!"
      else
        p "Pledge for task #{tasks[pledge.user_id][pledge.task_id][:content]} is still valid."
      end
    end

    p "Successful pledges: #{success_count}"
    p "Failed pledges (income): #{fail_count}"
  end

end
