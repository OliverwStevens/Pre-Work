colors = %w[blue orange green purple yellow pink]

code = []

def create_code(code, colors)
  4.times do
    code.push(colors.sample)
  end
end

create_code(code, colors)

p code
