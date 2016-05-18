class CreatePledges < ActiveRecord::Migration

  def change
    create_table :pledges do |t|
      t.string :task_id
      t.decimal :amount
      t.timestamps null: false
    end
  end

end
