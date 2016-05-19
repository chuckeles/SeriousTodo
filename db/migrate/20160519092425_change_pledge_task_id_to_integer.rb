class ChangePledgeTaskIdToInteger < ActiveRecord::Migration

  def change
    change_table :pledges do |t|
      t.remove :task_id
      t.integer :task_id
    end
  end

end
