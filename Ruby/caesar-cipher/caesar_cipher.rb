def caesar_cipher(message, shift)
  lowercase_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  uppercase_alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  encoded_message = ""
  
  message.split("").each do |letter|
    if lowercase_alphabet.include?(letter)
      index = lowercase_alphabet.index(letter)
      new_index = (index + shift) % 26
      encoded_message += lowercase_alphabet[new_index]
    elsif uppercase_alphabet.include?(letter)
      index = uppercase_alphabet.index(letter)
      new_index = (index + shift) % 26
      encoded_message += uppercase_alphabet[new_index]
    else
      encoded_message += letter
    end
  end
  
  puts encoded_message
end

caesar_cipher(gets.chomp, gets.chomp.to_i)
