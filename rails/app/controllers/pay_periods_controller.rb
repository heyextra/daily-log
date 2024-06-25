class PayPeriodsController < ApplicationController
    def show
      start_date = current_user.settings[:start_date]
      frequency = current_user.settings[:frequency] # Example frequency in weeks
      offset = params[:offset].to_i
  
      @current_offset = calculate_current_offset(start_date, frequency)
      @pay_period = pay_period_at_offset(start_date, frequency, @current_offset + offset)
      @period_tips = tips_between_dates(@pay_period[:start], @pay_period[:end]).group_by(&:occurred_on)
      @tip_sum = @period_tips.values.flatten.sum(&:personal_payout)
      @date = Date.today
      @date_range = (@pay_period[:start]..@pay_period[:end]).to_a
      

    end
  
    private
  
    def tips_between_dates(start_date, end_date)
        current_user.tips.where(occurred_on: start_date.beginning_of_day..end_date.end_of_day)
      end

      def tips_on_date(date)
        current_user.tips.where(occurred_on: date)
      end

    def calculate_current_offset(start_date, frequency)
      unless ( ((Date.today - start_date).to_i / 7.0) > 1 )
        weeks_passed = 0
      else
        weeks_passed = ((Date.today - start_date).to_i / 7.0).round
      end
      periods_passed = weeks_passed / frequency
      periods_passed
     
    end
  
    def pay_period_at_offset(start_date, frequency, offset)

      pay_period_start = start_date + (offset * frequency).weeks
      pay_period_end = pay_period_start + frequency.weeks - 1.day
  
      { start: pay_period_start, end: pay_period_end }
    end
  end
  