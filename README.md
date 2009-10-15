## CalculateAge

CalculateAge makes it easy to figure out age in days, weeks, months, or years. By default it assumes you want the age until today, but any end date can be provided.

It returns the age as you'd expect, especially when dealing with months and weeks.

### Example

    CalculateAge.of("10/13/2009", :in => "years") #=> "1 year"
    CalculateAge.of("9/8/2009", :in => "months") #=> "11 months"
    CalculateAge.of("10/5/2009", :in => "weeks") #=> "14 weeks"
    CalculateAge.of("3/23/2009", :in => "days") #=> "16 days"
    CalculateAge.of("4/17/2009", :in => "years and months") #=> "2 years and 3 months"
    CalculateAge.of("4/17/2009", :in => "years and months", :at => "7/19/2011") #=> "2 years and 3 months"

### Credits

Copyright (c) 2009 [Phronos](http://phronos.com), released under the MIT license
