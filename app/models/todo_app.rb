class TodoApp < ActiveRecord::Base

  belongs_to :user
  validates :token, presence: true

  def sql_insert
    return false unless valid?

    created_at = created_at || DateTime.now
    updated_at = updated_at || created_at

    ActiveRecord::Base.connection.execute <<-SQL
      begin;

      insert into todo_apps (user_id, token, created_at, updated_at)
      values ('#{user_id}', '#{token}', '#{created_at}', '#{updated_at}');

      commit;
    SQL
  end

end
