=begin
Find the total amount of the loan
  -Get the APR percertage that was locked in
  -Get the loan duration
    -Find the APR total base on the loan duration
      -Divide the total APR by the loan duration to get monthly APR payment
        -Find the total per month payment for the duration that the loan is active for
          -Add the monthly APR payment to the total per month  
=end
total_amount = ''
total_apr = ''
total_duration = ''


def monthly_payment(amount, duration)
  amount.to_f / duration.to_i
end


puts "Please enter the total amount of the loan"
total_amount = gets.chomp
puts "Please enter the total duration of the loan in months"
total_duration = gets.chomp
puts "Please enter the APR that was locked in."
total_apr = gets.chomp  

puts monthly_payment(total_amount, total_duration)

