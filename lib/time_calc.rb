class TimeCalc
  class << self
    def for(date,opts={})
      date = date.to_date
      end_date = opts[:until] ? opts.delete(:until).to_date : Date.today
      case opts[:in]
      when "days"
        time_in_days(date,end_date)
      when "weeks"
        time_in_weeks(date,end_date)
      when "months"
        time_in_months(date,end_date)
      when "years and months"
        time_in_years_and_months(date,end_date)
      else # years
        time_in_years(date,end_date)
      end
    end
    
    private
    
    # Primary methods
    
    def time_in_days(date,end_date)
      days = end_date - date
      return pluralize(days, "day")
    end
    
    def time_in_weeks(date,end_date)
      weeks = ((end_date - date) / 7).floor
      return pluralize(weeks, "week")
    end
    
    def time_in_months(date,end_date)
      if end_date.month >= date.month
        months = (end_date.year - date.year) * 12
        months = months + (end_date.month - date.month)
        months = months - 1 unless end_date.day >= date.day
      else
        months = 12 - date.month + end_date.month
      end
      months = 0 if months < 0
      return pluralize(months, "month")
    end

    def time_in_years(date,end_date)
      years = end_date.year - date.year
      
      if end_date.month < date.month
        years -= 1
      elsif end_date.day < date.day && end_date.month == date.month
        years -= 1
      end
      
      return pluralize(years, "year")
    end
    
    # Combined primary methods 
    
    def time_in_years_and_months(date,end_date)
      years = time_in_years(date,end_date)
      
      date_for_this_year = date + (end_date.year - date.year).years
      months = time_in_months(date_for_this_year,end_date)
      
      if years.to_i == 0
        return months
      elsif months.to_i == 0
        return years
      else
        return "#{years} and #{months}"
      end
    end
    
    # Support methods
    
    def pluralize(count, singular, plural = nil)
      "#{count || 0} " + ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
    end
  end
end