module TimesheetsHelper
  def name_week_day(wday)
    if wday == 1
      name = "Monday"
    elsif wday == 2
      name = "Tuesday"
    elsif wday == 3
      name = "Wednesday"
    elsif wday == 4
      name = "Thursday"
    elsif wday == 5
      name = "Friday"
    elsif wday == 6
      name = "Saturday"
    elsif wday == 0
      name= "Sunday"
    end
  end
end
