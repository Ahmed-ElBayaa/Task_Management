class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.date :start_date
      t.date :end_date
      t.string :version

      t.timestamps
    end
  end
end
