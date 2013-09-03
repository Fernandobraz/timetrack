class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :comment
      t.date :date
      t.time :time
      t.float :worked_hours
      t.integer :timesheet_id

      t.timestamps
    end
  end
end
