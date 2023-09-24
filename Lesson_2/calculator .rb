def prompt(message)
  Kernel.puts("=>#{message}")
end

def valid_number?(num)
 num.to_i() != 0
end

def action_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Enter your name:")

name = ''
loop do
 name = Kernel.gets().chomp()

 if name.empty?()
  prompt("Make sure to use a valid name.")
 else 
  break
 end
end

prompt("Hello #{name}")

loop do

  n1 = ''

  loop do
    prompt("Enter your first number, #{name}")
    n1 = gets.chomp
      
    if valid_number?(n1)
      break
    else
      prompt("Invalid number!")
    end
  end

  n2 = ''

  loop do 
    prompt("Enter your second number")
    n2 = gets.chomp
    
    if valid_number?(n2)
      break
    else
      prompt("Invalid number!")
    end
  end
  
  action_prompt = <<-MSG
    What operation would you like to perform?
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG

  prompt(action_prompt)

  action = ' '
  loop do
      action = gets.chomp
  
      if %w(1 2 3 4).include?(action)
        break
      else
        prompt("Must choose 1, 2, 3 or 4")
    end
  end

    prompt("#{action_to_message(action)} the numbers #{n1} and #{n2}")


    result = case action
    when '1'
      n1.to_i + n2.to_i
    when '2'
      n1.to_i - n2.to_i
    when '3'
      n1.to_i * n2.to_i
    when '4'
      n1.to_f / n2.to_f
    end
      
      
    prompt("The result is #{result}")
      
    prompt("Do you want to perform another calculation? (Y to calculate again)")
    answer = Kernel.gets().chomp()
    break unless answer.downcase().start_with?('y')
  end
prompt("Thank you for using the calculator #{name}!")