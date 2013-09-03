class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :project_id
      t.integer :user_id
      t.date  :start_date
      t.date  :end_date

      t.timestamps
    end
  end
end
