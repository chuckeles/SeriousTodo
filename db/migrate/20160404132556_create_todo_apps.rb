class CreateTodoApps < ActiveRecord::Migration

  def change
    create_table :todo_apps do |t|
      t.belongs_to :user, index: true
      t.string :token, null: false
      t.timestamps null: false
    end
  end

end
