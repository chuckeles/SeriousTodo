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

  def sql_update
    return false unless valid?

    self.updated_at = DateTime.now

    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.update <<-SQL
        update todo_apps
        set user_id = '#{user_id}',
            token = '#{token}',
            updated_at = '#{updated_at}'
      SQL
    end
  end

  def sql_delete
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.delete <<-SQL
        delete
        from todo_apps
        where id = '#{id}'
      SQL
    end
  end

  def self.sql_find_by_id(id)
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.select_one <<-SQL
        select *
        from todo_apps
        where id = '#{id}'
      SQL
    end
  end

  def self.sql_find_by_user(user_id)
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.select_all <<-SQL
        select *
        from todo_apps
        where user_id = '#{user_id}'
      SQL
    end.to_hash
  end

end
