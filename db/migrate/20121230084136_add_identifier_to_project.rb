class AddIdentifierToProject < ActiveRecord::Migration
  def change
    add_column :projects, :identifier, :string
  end
end
