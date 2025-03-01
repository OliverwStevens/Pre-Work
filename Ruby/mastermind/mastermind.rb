colors = %w[blue orange green purple yellow pink]
code = []

# Function to generate the secret code
def create_code(code, colors)
  4.times { code.push(colors.sample) }
end

# Function to make a guess with validation
def make_guess(colors)
  guess = []
  4.times do |num|
    loop do
      puts "What is in position #{num + 1}? Choose from: #{colors.join(', ')}"
      guess_input = gets.chomp.downcase

      # Validate the input to make sure it's a valid color
      if colors.include?(guess_input)
        guess.push(guess_input)
        break
      else
        puts "Invalid color. Please choose a valid color from: #{colors.join(', ')}"
      end
    end
  end
  guess
end

# Function to check the guess and provide feedback
def check_code(guess, code)
  if guess == code
    puts "You win!"
    true
  else
    feedback = []
    code.each_with_index do |color, index|
      if color == guess[index]
        feedback.push("red") # Correct color in correct position
      elsif code.include?(guess[index])
        feedback.push("white") # Correct color, wrong position
      else
        feedback.push(" ") # Incorrect color
      end
    end
    feedback
  end
end

# Create a secret code
create_code(code, colors)
p code
puts "Welcome to Mastermind! Try to guess the secret code!"

# Game loop: Player has 10 attempts to guess
10.times do |i|
  puts "\nAttempt ##{i + 1}:"
  guess = make_guess(colors)

  feedback = check_code(guess, code)

  if feedback == true
    puts "Game over"
    break
  else
    # Display feedback to the player
    red_count = feedback.count("red")
    white_count = feedback.count("white")
    puts "Feedback: #{red_count} red(s), #{white_count} white(s)"
  end
end
