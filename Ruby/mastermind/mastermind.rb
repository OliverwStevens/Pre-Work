colors = %w[blue orange green purple yellow pink]

code = []

def create_code(code, colors)
  code.push(colors.sample)
end

create_code(code, colors)

puts code
