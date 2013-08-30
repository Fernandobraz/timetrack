class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :project_id
      t.integer :user_id
      t.date :day
      t.float :worked_hours

      t.timestamps
    end
  end
end
