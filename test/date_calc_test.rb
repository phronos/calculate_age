require 'test_helper'

class DateCalcTest < Test::Unit::TestCase
  def test_time_in_years
    pretend_now_is(2009,"sep",9) do    
      assert_equal "1 year", DateCalc.for(425.days.ago)
      assert_equal "2 years", DateCalc.for((2*380).days.ago)
      assert_equal "4 years", DateCalc.for(4.years.ago, :in => "years")
      assert_equal "7 years", DateCalc.for((8.years-1.day).ago)
    end
  end
    
  def test_time_in_months
    pretend_now_is(2009,"sep",9) do
      assert_equal "1 month", DateCalc.for(45.days.ago,:in => "months")
      assert_equal "0 months", DateCalc.for(4.days.ago,:in => "months")
      assert_equal "3 months", DateCalc.for(3.months.ago,:in => "months")
      assert_equal "2 months", DateCalc.for((3.months-1.day).ago,:in => "months")
      assert_equal "3 months", DateCalc.for((3.months+1.day).ago,:in => "months")
      assert_equal "18 months", DateCalc.for("3/8/2008",:in => "months")
    end
    
    pretend_now_is(2009,'sep',24) do
      assert_equal "10 months", DateCalc.for(10.months.ago,:in => "months")
    end
  end
  
  def test_time_in_weeks
    pretend_now_is(2009,"sep",9) do
      assert_equal "1 week", DateCalc.for(9.days.ago, :in => "weeks")
      assert_equal "7 weeks", DateCalc.for(7.weeks.ago, :in => "weeks")
      assert_equal "3 weeks", DateCalc.for(24.days.ago, :in => "weeks")
      assert_equal "1 week", DateCalc.for(7.days.ago, :in => "weeks")
      assert_equal "4 weeks", DateCalc.for(1.month.ago, :in => "weeks")
    end
  end
  
  def test_time_in_days
    pretend_now_is(2009,"sep",9,12) do
      assert_equal "9 days", DateCalc.for(9.days.ago, :in => "days")
      assert_equal "49 days", DateCalc.for(7.weeks.ago, :in => "days")
      assert_equal "24 days", DateCalc.for(24.days.ago, :in => "days")
      assert_equal "7 days", DateCalc.for(7.days.ago, :in => "days")
      assert_equal "31 days", DateCalc.for(1.month.ago, :in => "days")
    end
  end
  
  def test_time_in_years_and_months
    pretend_now_is(2009,"sep",9) do
      assert_equal "1 month", DateCalc.for(45.days.ago, :in => "years and months")
      assert_equal "4 years", DateCalc.for(4.years.ago, :in => "years and months")
      assert_equal "2 years and 4 months", DateCalc.for((2.years+130.days).ago, :in => "years and months")
      assert_equal "1 year and 5 months", DateCalc.for(17.months.ago, :in => "years and months")
    end
  end
  
  def test_february
    pretend_now_is(2009,"feb",28) do
      assert_equal "0 months", DateCalc.for("2/1/2009", :in => "months")
      assert_equal "3 weeks", DateCalc.for("2/1/2009", :in => "weeks")
    end
    
    pretend_now_is(2009,"mar",1) do
      assert_equal "1 month", DateCalc.for("2/1/2009", :in => "months")
      assert_equal "4 weeks", DateCalc.for("2/1/2009", :in => "weeks")
    end
  end
  
  def test_leap_year
    pretend_now_is(2009,"feb",1) do
      assert_equal "1 year", DateCalc.for("1/31/2008")
      assert_equal "12 months", DateCalc.for("1/31/2008", :in => "months")
    end
    
    pretend_now_is(2009,"feb",28) do
      assert_equal "0 years", DateCalc.for("2/29/2008")
      assert_equal "11 months", DateCalc.for("2/29/2008", :in => "months")
    end
    
    pretend_now_is(2008,"feb",29) do
      assert_equal "0 months", DateCalc.for("1/31/2008", :in => "months")
      assert_equal "0 months", DateCalc.for("2/1/2008", :in => "months")
      assert_equal "366 days", DateCalc.for("2/28/2007", :in => "days")
      assert_equal "365 days", DateCalc.for("3/1/2007", :in => "days")
    end
    
    pretend_now_is(2008,"mar",1) do
      assert_equal "1 month", DateCalc.for("1/31/2008", :in => "months")
      assert_equal "1 month", DateCalc.for("2/1/2008", :in => "months")
    end
    
    pretend_now_is(2008,"mar",31) do
      assert_equal "2 months", DateCalc.for("1/31/2008", :in => "months")
      assert_equal "1 month", DateCalc.for("2/1/2008", :in => "months")
    end
  end
  
  def test_for_dates_other_than_today
    assert_equal "2 months", DateCalc.for("1/31/2008", :in => "months", :until => "3/31/2008")
    assert_equal "1 month", DateCalc.for("2/1/2008", :in => "months", :until => "3/31/2008")
    assert_equal "0 months", DateCalc.for("1/31/2008", :in => "months", :until => "2/29/2008")
    assert_equal "0 months", DateCalc.for("2/1/2008", :in => "months", :until => "2/29/2008")
    assert_equal "366 days", DateCalc.for("2/28/2007", :in => "days", :until => "2/29/2008")
    assert_equal "365 days", DateCalc.for("3/1/2007", :in => "days", :until => "2/29/2008")
  end
end
