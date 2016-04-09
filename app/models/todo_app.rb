class TodoApp < ActiveRecord::Base

  belongs_to :user
  validates :token, presence: true

  def sql_insert
    self.created_at = self.updated_at = DateTime.now

    do_transaction = !ActiveRecord::Base.connection.transaction_open?

    ActiveRecord::Base.connection.begin_db_transaction if do_transaction
    self.id = ActiveRecord::Base.connection.insert <<-SQL
      insert into todo_apps (user_id, token, created_at, updated_at)
      values (#{user_id.to_i}, #{ActiveRecord::Base.sanitize(token)}, #{ActiveRecord::Base.sanitize(created_at)}, #{ActiveRecord::Base.sanitize(updated_at)})
    SQL

    if not valid? or not self.id
      ActiveRecord::Base.connection.rollback_db_transaction if do_transaction
      false
    else
      ActiveRecord::Base.connection.commit_db_transaction if do_transaction
      true
    end
  end

  def sql_update
    return false unless valid?

    self.updated_at = DateTime.now

    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.update <<-SQL
        update todo_apps
        set user_id = #{user_id.to_i},
            token = #{ActiveRecord::Base.sanitize(token)},
            updated_at = #{ActiveRecord::Base.sanitize(updated_at)}
      SQL
    end
  end

  def sql_delete
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.delete <<-SQL
        delete
        from todo_apps
        where id = #{id.to_i}
      SQL
    end
  end

  def self.sql_find_by_id(id)
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.select_one <<-SQL
        select *
        from todo_apps
        where id = #{id.to_i}
      SQL
    end
  end

  def self.sql_find_by_user(user_id)
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.select_all <<-SQL
        select *
        from todo_apps
        where user_id = #{user_id.to_i}
      SQL
    end.to_hash
  end

  def self.sql_count_by_users_ordered
    ActiveRecord::Base.connection.transaction do
      ActiveRecord::Base.connection.select_all <<-SQL
        select users.id as user_id, count(todo_apps.id) as todo_apps_count
        from users
        join todo_apps on user_id = users.id
        group by users.id
        order by todo_apps_count desc
      SQL
    end.to_hash
  end

end
