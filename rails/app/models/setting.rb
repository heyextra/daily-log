class Setting < ApplicationRecord
  belongs_to :user

  validates :time_zone, time_zone: true

  enum measurement_system: {
    imperial: "imperial",
    metric: "metric"
  }

  def water_unit
    WaterEntry.units[measurement_system.to_sym]
  end

  def pay_period(start_date, frequency)
    start_date + frequency.weeks
  end

  def current_pay_period(start_date, frequency)
    # Calculate the number of weeks that have passed since the start date
    weeks_passed = ((Date.today - start_date).to_i / 7.0).ceil
  
    # Calculate the number of complete pay periods that have occurred
    periods_passed = weeks_passed / frequency
  
    # Calculate the start date of the current pay period
    current_pay_period_start = start_date + (periods_passed * frequency).weeks
  
    # Calculate the end date of the current pay period
    current_pay_period_end = current_pay_period_start + frequency.weeks - 1.day
  
    { start: current_pay_period_start, end: current_pay_period_end }
  end
  
#   def pay_period
#     schedule = IceCube::Schedule.new
#     schedule.add_recurrence_rule(
#         IceCube::Rule.weekly(:frequency, :start_day)
# )
# end
end
