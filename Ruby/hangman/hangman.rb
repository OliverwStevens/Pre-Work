require "json"

def save_game(a, w, l)
  puts "Name your game:"
  file_name = "./Ruby/hangman/lib/#{gets.chomp}.json"

  game_state = {
    answer: a,
    word: w,
    lives: l
  }

  File.write(file_name, JSON.pretty_generate(game_state))

  puts "Game saved to #{file_name}."
end

def load_game(file_name)
  game_state = JSON.parse(File.read(file_name))
  play_game(game_state["answer"], game_state["word"], game_state["lives"])
end

def new_answer
  content = File.read("./Ruby/hangman/words.txt").split(" ")
  filtered_answers = content.reject { |answer| answer.length < 5 || answer.length > 12 }
  answer = filtered_answers.sample
end

def play_game(answer, word, lives)
  puts word.join(" ")
  puts "You can save your games with /s"
  until word.join("") == answer
    puts "What is your guess?"
    letter = gets.chomp.to_s.downcase
    next if letter == ""

    if letter == "/s"
      save_game(answer, word, lives)
      return
      break
    end
    break if letter == answer

    answer.chars.each_with_index do |char, index|
      word[index] = letter if char == letter
    end
    unless answer.chars.include?(letter)
      lives -= 1
      puts "That's not good."
      if lives == 0
        puts "It's over, the answer was #{answer}."
        return
      end
    end
    puts word.join(" ")
    puts "lives left: #{lives}"
  end

  puts "Congratulations! You guessed the word: #{answer} in #{lives} lives."
end

puts "Do you want to load a game? Type yes or no:"

load = gets.chomp.to_s.downcase
if load == "yes"
  puts "Type the name of your game."
  game = "./Ruby/hangman/lib/#{gets.chomp}.json"
  load_game(game)
else
  answer = new_answer

  play_game(answer, Array.new(answer.length, "_"), 5)
end
