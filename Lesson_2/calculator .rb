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
     
    result = case action
    when '1'
      n1.to_i + n2.to_i
    when '2'
      n1.to_i - n2.to_i
    when '3'
      n1.to_i * n2.to_i
    when '4'
      n1.to_f / n2.to_f
    else
      prompt("Invalid action! Try again!")
      break
    end
    prompt("The result is #{result}")
    return
  end
end
