=begin
Find the total amount of the loan
  -Get the APR percertage that was locked in
  -Get the loan duration
    -Find the APR total base on the loan duration
      -Divide the total APR by the loan duration to get monthly APR payment
        -Find the total per month payment for the duration that the loan is active for
          -Add the monthly APR payment to the total per month  
=end

puts "Please enter the total amount of the loan"
total_loan = gets.chomp.to_f
puts "Please enter the total duration of the loan in months"
total_duration = gets.chomp.to_f
puts "Please enter the APR that was locked in."
total_apr = gets.chomp.to_f

apr_payment = ((total_apr / 100) / 12)

monthly_payment = total_loan * (apr_payment / (1 - (1 + apr_payment)**(-total_duration)))

puts "Your monthly payment is #{monthly_payment}"

