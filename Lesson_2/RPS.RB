VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
  (first == 'rock' && second == 'lizard') ||
  (first == 'paper' && second == 'rock') ||
  (first == 'paper' && second == 'spock') ||
  (first == 'scissors' && second == 'paper') || 
  (first == 'scissors' && second == 'lizard') ||
  (first == 'lizard' && second == 'spock') ||
  (first == 'lizard' && second == 'paper') ||
  (first == 'spock' && second == 'scissors') ||
  (first == 'spock' && second == 'rock')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("The computer won :(")
  else 
    prompt("It is a tie!")
  end
end

def prompt(message)
  puts("=> #{message}")
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

