=begin
Provide three choices for user
  -Rock, Paper, Scissor
    -Rock will win against Scissor
      -lose to Paper
    -Paper should be valued over Rock
      -lose to Scissor
    -Scissor should be valued Paper
      -lose to Rock
Ask user for a choice
  -Assign computer with a random choice
    -Compare the result
      -Print result
        -Ask user if they want to play again
          -If yes, play again
          -If no, exit the program
=end

def prompt_Rock_Paper_Scissor
  prompt = "Rock, Paper, Scissor"
  puts prompt
end



RPS_prompt = <<MSG
Please choose one
1)Rock
2)Paper
3)Scissor
MSG


RPS_array = ["Rock", "Paper", "Scissor"].sample

puts "Welcome to the game Rock, Paper, Scissor!"
puts "What is your name?"
name = gets.chomp
puts "Hi #{name}!, lets play some rock, paper, scissor!"
puts "-------------------------------------------------"
puts " "
puts RPS_prompt
choice = gets.chomp




if RPS_array == choice 
  puts "The computer choice #{RPS_array} and you chose #{choice} making it a tie!"
elsif 
  RPS_array ==  "Rock" && choice == "Paper" 
  puts "The computer choice #{RPS_array} and you chose #{choice} making you the winner!"
elsif 
  RPS_array ==  "Paper" && choice == "Rock" 
  puts "The computer choice #{RPS_array} and you chose #{choice} making you the loser."
elsif 
  RPS_array ==  "Paper" && choice == "Scissor" 
  puts "The computer choice #{RPS_array} and you chose #{choice} making you the winner!"
elsif 
  RPS_array ==  "Scissor" && choice == "Paper" 
  puts "The computer choice #{RPS_array} and you chose #{choice} making you the loser."


#Notice that, while I can continue working on my code, there will be a bunch of lines. Going to start watching the assignment video now. My inexperience-self was going to do a bunch of if/else.