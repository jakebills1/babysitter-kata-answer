require_relative './babysitter'

babysitter = Babysitter.new
puts 'Welcome to your night of babysitting. Ready to clock in?'
while !@clock_in_time_entered
  begin
    puts "Enter hour started:"
    hour = gets.chomp.gsub(':00', '')
    puts "AM or PM?"
    ampm = gets.chomp.upcase.gsub('.', '')
    babysitter.clock_in("#{hour} #{ampm}")
    @clock_in_time_entered = true
  rescue ArgumentError => e
    puts e.message
    puts "Try Again"
  end
end
while !@clock_out_time_entered
  begin
    puts "Enter hour ended:"
    hour = gets.chomp.gsub(':00', '')
    puts "AM or PM?"
    ampm = gets.chomp.upcase.gsub('.', '')
    babysitter.clock_out("#{hour} #{ampm}")
    @clock_out_time_entered = true
  rescue ArgumentError => e
    puts e.message
    puts "Try Again"
  end
end

puts "You have earned #{babysitter.calculate_nightly_pay}"


