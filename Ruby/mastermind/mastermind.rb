colors = %w[blue orange green purple yellow pink]
code = []
computer_guess = [nil, nil, nil, nil]

# Function to generate the secret code
def create_code(code, colors)
  4.times { code.push(colors.sample) }
  code
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
def check_code(guess, code, computer_guess)
  if guess == code
    puts "You win!"
    true
  else
    feedback = []
    temp_code = code.dup
    temp_guess = guess.dup

    # First check for exact matches (red pegs)
    temp_code.each_with_index do |color, index|
      next unless color == temp_guess[index]

      feedback.push("red") # Correct color in correct position
      computer_guess[index] = color if computer_guess
      temp_code[index] = nil
      temp_guess[index] = nil
    end

    # Then check for color matches (white pegs)
    temp_guess.each_with_index do |color, index|
      next if color.nil?

      if temp_code.include?(color)
        feedback.push("white") # Correct color, wrong position
        temp_code[temp_code.index(color)] = nil
      else
        feedback.push(" ") # Incorrect color
      end
    end

    feedback
  end
end

def make_computer_guess(colors, computer_guess)
  guess = []
  4.times do |num|
    if computer_guess[num].nil?
      guess.push(colors.sample)
    else
      guess.push(computer_guess[num])
    end
  end

  puts "Computer guesses: #{guess.join(', ')}"
  guess
end

# Main game
puts "Welcome to Mastermind! Try to guess the secret code or beat the computer!"
puts "Type 'yes' if you want to guess or 'no' to make the code"
human = gets.chomp.downcase == "yes"

if human
  code = create_code(code, colors)
  puts "Secret code has been created!"
else
  puts "You'll create the code and the computer will try to guess it."
  code = make_guess(colors)
end

# Game loop: Player has 10 attempts to guess
10.times do |i|
  puts "\nAttempt ##{i + 1}:"

  guess = if human
            make_guess(colors)
          else
            make_computer_guess(colors, computer_guess)
          end

  feedback = check_code(guess, code, human ? nil : computer_guess)

  if feedback == true
    puts "Game over"
    break
  else
    # Display feedback to the player
    red_count = feedback.count("red")
    white_count = feedback.count("white")
    puts "Feedback: #{red_count} red(s), #{white_count} white(s)"

    # If all attempts are used up
    if i == 9 && feedback != true
      puts "Game over! You ran out of attempts."
      puts "The secret code was: #{code.join(', ')}"
    end
  end
end
