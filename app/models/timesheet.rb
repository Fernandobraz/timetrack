class Timesheet < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :tasks
  
  def quantity_of_working_days
    (self.end_date - self.start_date).to_i
  end
  def working_days
    working_days = [self.start_date]
    self.quantity_of_working_days.times do |i|
      working_days << (self.start_date + i.days)
    end
    working_days
  end
  
  
  def working_hours_sum_of(day)
    sum = 0.0
    self.tasks.where(date: day).each do |t|
      sum = sum + t.worked_hours
    end
    return sum
  end
end
