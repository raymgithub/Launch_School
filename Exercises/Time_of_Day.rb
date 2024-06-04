
def time_of_day(time)
	hour, minute = time.divmod(60)

	if time < 0
		hour = hour % 24
	elsif hour > 24
		hour = hour % 24
	end

 hour = "00" if hour == 0
 minute = "00" if minute == 0 
	
 hour = "0" + hour.to_s if hour.to_s.size == 1
 minute = "0" + minute.to_s if minute.to_s.size == 1

puts "#{hour}:#{minute}"
"#{hour}:#{minute}"
end

time_of_day(-3) == "23:57"
time_of_day(35) == "00:35" 
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00" 
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
time_of_day(-4232) == "01:30"

