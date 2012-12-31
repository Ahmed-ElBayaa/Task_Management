class AddAssigneeItToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :assignee_id, :integer
  end
end
