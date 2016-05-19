class PledgeBelongsToUser < ActiveRecord::Migration

  def change
    change_table :pledges do |t|
      t.belongs_to :user, index: true
    end
  end

end
