 loop do
  loop do
    puts "Enter your first number"
    n1 = gets.chomp
    puts "Enter your second number"
    n2 = gets.chomp
    puts "What do you want to do? 1.)Add 2.)Subtract 3.)Multiply 4.)Divide"
    action = gets.chomp.to_s.upcase

    if action == "ADD" ||  action == "1"
      result = n1.to_i + n2.to_i
    elsif action == "SUBTRACT" || action == "2"
      result = n1.to_i - n2.to_i  
    elsif action == "SUBTRACT" || action == "3"
      result = n1.to_i * n2.to_i  
    elsif action == "DIVIDE" || action == "4"
      result = n1.to_f / n2.to_f  
    else 
      puts "Invalid action! Try again!"
      break
    end
      
    puts "The result is #{result}"
    return
  end
end
