VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts("=> #{message}")
end

def display_results(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
    (player == 'paper' && computer == 'rock') ||
    (player == 'scissors' && computer == 'paper')
    prompt("You won!")
  elsif (player == 'rock' && computer == 'paper') ||
    (player == 'paper' && computer == 'scissors') ||
    (player == 'scissors' && computer == 'rock')
    prompt("The computer won :(")
  else 
    prompt("It is a tie!")
  end
end


loop do

  user_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    user_choice = gets.chomp  

    if VALID_CHOICES.include?(user_choice)
      break
    else
      prompt("That is not a valid choice.")
    end
  end


  computer_choice = VALID_CHOICES.sample


  puts "You chose: #{user_choice}; Computer chose: #{computer_choice}"

  display_results(user_choice, computer_choice)

  prompt("Do you want to play again? y(es) / n(o)")
  user_answer = gets.chomp
  break unless user_answer.downcase.start_with?('y')
end

prompt("Thank you for playing!")