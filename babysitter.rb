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
    @clock_in_time = convert_to_military(time)
  end
  def clock_out(time)
    @clock_out_time = convert_to_military(time)
  end
  def calculate_nightly_pay
  end
  private
  def convert_to_military(time)
    # time = '5 PM'
    # separate hour from am/pm
    #

  end
end

