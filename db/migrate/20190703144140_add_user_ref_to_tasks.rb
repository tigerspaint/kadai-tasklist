class AddUserRefToTasks < ActiveRecord::Migration[5.2]
  def change
    # add_column :tasks, :user_id, :integer
    add_reference :tasks, :user, foreign_key: true
  end
end
