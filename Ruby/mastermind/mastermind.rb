colors = %w[blue orange green purple yellow pink]

code = []

def create_code(code, colors)
  4.times do
    code.push(colors.sample)
  end
end

def make_guess(colors)
  guess = []
  4.times do |num|
    puts "What is in postition #{num + 1}?"
    # puts "Colors:"
    puts colors.join(" ")
    guess.push(gets.chomp)
  end
  guess
end

def check_code(guess, code)
  if guess == code
    puts "You win!"
    true
  else
    output = []
    code.each_with_index do |color, index|
      if color == guess[index]
        output.push("red")
      elsif code.include?(guess[index])
        output.push("white")
      else
        output.push(" ")
      end
    end
    output
  end
end
create_code(code, colors)
p code

10.times do
  won = check_code(make_guess(colors), code)
  if won == true
    p "Game over"
    break
  end
end
