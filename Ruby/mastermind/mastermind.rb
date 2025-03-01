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

create_code(code, colors)
p make_guess(colors)
p code
