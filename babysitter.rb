# methods: clock_in, clock_out, calculate
#   clock_in: get time starting job (validate rules)
#     store input ( fair amount of rules for entering, since no gui input)
#   clock_out: get time ending job (validate rules)
#     store input
#   calculate: get amount of pay. both clock_in and clock_out must have been called
#     take stored values from other methods and calculate price to charge based on rules
#     bonus: if clock_out wasn't called default to latest value
#     
# assume bedtime is reasonable time like 8PM
#
# test
#   price is accurate
#   clock_in/out is required to calculate
#   if input invalid, prompt input again
#
# design
#   maybe entering time start starts endless loop. leave this as a bonus, tho. make sure behavior in prompt is under test
#
#   three files: main (with prompts), babysitter (where class is), and babysitter_spec. + Gemfile
#   save time input as military based off of whether AM or PM is entered
#   acceptable time range (5PM - 4AM) can be expressed as zero based range from 0 - 11
#

class Babysitter
  def initialize
  end
  def clock_in(time)
    converted_time = convert_to_military(time)
    if converted_time < 17
      raise ArgumentError, 'Cannot clock in earlier than 5 PM'
    end
    @clock_in_time = converted_time 
  end
  def clock_out(time)
    converted_time = convert_to_military(time)
    if converted_time == @clock_out_time
      raise ArgumentError, 'Clock out time cannot be same as clock in time'
    end
    if converted_time > 4 && converted_time < 17
      raise ArgumentError, 'Cannot clock out later than 4 AM'
    end
    if @clock_in_time.nil?
      raise ArgumentError, 'Must enter clock in time first'
    end
    if converted_time > 4 && converted_time < @clock_in_time
      raise ArgumentError, 'Clock out time must be after clock in time'
    end
    @clock_out_time = convert_to_military(time)
  end
  def calculate_nightly_pay
    if @clock_in_time.nil? || @clock_out_time.nil?
      raise ArgumentError, 'Cannot calculate pay unless both clock in and clock out times entered'
    end
    # need continous positive numbers to loop over
    adjusted_clock_out_time = if @clock_out_time < 5 # midnite to 4 AM
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
    # time = '5 PM'
    # separate hour from am/pm
    #
    hour, ampm = time.split(' ')
    if ampm == 'AM'
      hour.to_i % 12 # make sure 12 AM is 0
    else
      hour.to_i + 12
    end
  end
end

