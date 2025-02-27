
def caesar_cipher(message, shift)
    alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    encoded_message = ""
    message.split("").each do |letter|
      if alphabet.include?(letter)
        index = alphabet.index(letter)
  
        new_index = index + shift
        if new_index > 25
          new_index = new_index - 26
        end
        encoded_message += alphabet[new_index]
      else
        encoded_message += letter
      end
    end
    puts encoded_message
  end
  caesar_cipher(gets.chomp.downcase, gets.chomp.to_i)
  