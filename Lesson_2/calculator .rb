def prompt(message)
  Kernel.puts("=>#{message}")
end


loop do
  loop do
    prompt("Enter your first number")
    n1 = gets.chomp
    prompt("Enter your second number")
    n2 = gets.chomp
    prompt("What do you want to do? 1.)Add 2.)Subtract 3.)Multiply 4.)Divide")
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
      prompt("Invalid action! Try again!")
      break
    end
      
    prompt("The result is #{result}")
    return
  end
end
