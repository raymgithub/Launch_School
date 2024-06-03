=begin
Find the total amount of the loan
  -Get the APR percertage that was locked in
  -Get the loan duration
    -Find the APR total base on the loan duration
      -Divide the total APR by the loan duration to get monthly APR payment
        -Find the total per month payment for the duration that the loan is active for
          -Add the monthly APR payment to the total per month  
=end

def valid_interger?(num)
  num.to_i.to_s == num
end
  
def valid_float?(num)
  num.to_f.to_s == num
end

def number?(num)
  valid_interger?(num) || valid_float?(num)
end


total_loan = ' '
loop do
  puts "Please enter the total amount of the loan"
  total_loan = gets.chomp

  break if number?(total_loan)
    puts "Please enter a valid number"
end

total_duration = ' '
loop do
  puts "Please enter the total duration of the loan in months"
  total_duration = gets.chomp

  break if number?(total_duration)
  puts "Please enter a valid number"
end

total_apr = ' '
loop do
  puts "Please enter the APR that was locked in."
  total_apr = gets.chomp
  break if number?(total_apr)
  puts "Please enter a valid number"
end


apr_payment = ((total_apr.to_f / 100) / 12)

monthly_payment = total_loan.to_i * (apr_payment.to_f / (1 - (1 + apr_payment.to_f)**(-total_duration.to_i)))


message = <<-MSG
  The infomation you entered are:
  Loan amount = $#{total_loan}
  Duration of Loan in months = #{total_duration} months
  Locked APR in percertage = %#{total_apr}
  -----------------------------------
  Making your monthly payment = #{monthly_payment.round(2)}
  MSG

puts message 

