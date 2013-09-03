class AddColunmSubmitedOnTimesheet < ActiveRecord::Migration
  def change
    add_column :timesheets, :submited?, :boolean, :null => false, :default => false
  end
end
