def fibs(n)
  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2

  fib_sequence = [0, 1]
  (n - 2).times do
    fib_sequence.push(fib_sequence[-1] + fib_sequence[-2])
  end
  fib_sequence
end

def fibs_rec(n, sequence = [0, 1])
  puts "This was printed recursively"
  return sequence[0...n] if n <= sequence.length

  sequence.push(sequence[-1] + sequence[-2])
  fibs_rec(n, sequence)
end

puts fibs(8)
puts fibs_rec(8)
