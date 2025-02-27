def substrings(word, dictionary)
  dictionary = dictionary.map(&:downcase)
  word.downcase!

  substrings_found = {}

  dictionary.each do |term|
    count = word.scan(term).size

    if count > 0
      substrings_found[term] = count
    end
  end

  puts substrings_found
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
substrings("Howdy partner, sit down! How's it going?", dictionary)
