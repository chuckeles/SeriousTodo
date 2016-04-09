class TodoApp < ActiveRecord::Base

  belongs_to :user
  validates :token, presence: true

  def sql_insert
    return false unless valid?

    self.created_at = self.updated_at = DateTime.now

    ActiveRecord::Base.connection.transaction do
      self.id = ActiveRecord::Base.connection.insert <<-SQL
        insert into todo_apps (user_id, token, created_at, updated_at)
        values ('#{user_id}', '#{token}', '#{created_at}', '#{updated_at}')
      SQL
    end
  end

end
