class Babysitter
  def initialize
  end
  def clock_in(time)
    converted_time = convert_to_military(time)
    validate_clock_in_arg(converted_time)
    @clock_in_time = converted_time 
  end
  def clock_out(time)
    converted_time = convert_to_military(time)
    validate_clock_out_arg(converted_time)
    @clock_out_time = convert_to_military(time)
  end
  def calculate_nightly_pay
    validate_required_data
    # need continous positive numbers to loop over
    # only necessary if clock in before midnight
    adjusted_clock_out_time = if @clock_out_time < 5 && @clock_in_time > 5 # midnite to 4 AM
                                # midnite becomes 24, 1 becomes 25
                                @clock_out_time + 24 
                              else
                                @clock_out_time
                              end
    work_hours = @clock_in_time...adjusted_clock_out_time # exclusive of clock out hour, since not paid for that hour
    pay = 0
    work_hours.each do |hour|
      hour = hour >= 24 ? hour - 24 : hour # remove the adjustment made for looping
      pay += hourly_price(hour) 
    end
    "$#{pay}"
  end
  private
  def hourly_price(hour)
    # assuming 8PM (20) is bedtime
    case hour
    when 17..19 # 5 PM to bedtime
      12
    when 20..23 # bedtime to midnight
      8
    when 0..4 # midnight to 4 AM
      16
    end
  end
  def convert_to_military(time)
    hour, ampm = time.split(' ')
    if ampm == 'AM'
      hour.to_i % 12 # make sure 12 AM is 0
    else
      hour.to_i + 12
    end
  end
  def validate_clock_in_arg(arg)
    if arg < 17 && arg > 3
      raise ArgumentError, 'Cannot clock in earlier than 5 PM'
    end
  end
  def validate_clock_out_arg(arg)
    if arg == @clock_in_time
      raise ArgumentError, 'Clock out time cannot be same as clock in time'
    end
    if arg > 4 && arg < 17
      raise ArgumentError, 'Cannot clock out later than 4 AM'
    end
    if @clock_in_time.nil?
      raise ArgumentError, 'Must enter clock in time first'
    end
    if arg > 4 && arg < @clock_in_time
      raise ArgumentError, 'Clock out time must be after clock in time'
    end
  end
  def validate_required_data
    if @clock_in_time.nil? || @clock_out_time.nil?
      raise ArgumentError, 'Cannot calculate pay unless both clock in and clock out times entered'
    end
  end
end

