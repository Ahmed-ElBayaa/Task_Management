class AddAttachmentToTask < ActiveRecord::Migration
  def self.up
    add_attachment :tasks, :attachment
  end

  def self.down
    remove_attachment :tasks, :attachment
  end
end
