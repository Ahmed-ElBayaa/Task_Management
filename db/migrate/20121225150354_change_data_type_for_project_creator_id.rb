class ChangeDataTypeForProjectCreatorId < ActiveRecord::Migration
  def up
  	change_column :projects, :creator_id, :integer
  end

  def down
  	change_column :projects, :creator_id, :string
  end
end
