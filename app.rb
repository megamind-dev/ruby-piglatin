class PigLatin
  def translate(phrase)
    words = []

    phrase.split.map do |word|
      # identify cases
      capital_state = "lowercase"
      capital_state = "upcase" if word == word.upcase
      capital_state = "capitalized" if word == word.capitalize
      word = word.downcase

      # seperate word and special characters, convert word into pig latin
      first, last = seperate_word_and_special_chars(word)
      word = convert_word(first) + last
    
      # apply word case into translated word
      word = word.upcase if capital_state == "upcase"
      word = word.capitalize if capital_state == "capitalized"
      words << word
    end

    words.join(' ')
  end

  def seperate_word_and_special_chars(word)
    letters = word.split('')
    firsthalf = []
    lasthalf = letters.dup

    letters.map do |letter|
      break if !letter.match(/[a-zA-Z'-]/)
      firsthalf << letter
      lasthalf.shift
    end
    [firsthalf.join, lasthalf.join]
  end

  def convert_word(word)
    letters = word.split('')
    firsthalf = []
    lasthalf = letters.dup

    letters.map do |letter|
      if firsthalf.last == 'q' && letter == 'u'  # handle special case: check 'qu'
        firsthalf << letter
        lasthalf.shift
        next
      end
      break if firsthalf.empty? && letter == 'y' && lasthalf[1] == 'e'  # handle special case: check 'ye'
      break if %w(a e i o u).include?(letter)
      firsthalf << letter
      lasthalf.shift
    end
    
    firsthalf.empty? ? lasthalf.join + "way" : lasthalf.join + firsthalf.join + "ay"
  end

end

piglatin = PigLatin.new
# puts piglatin.translate("HELLO?!")

while 1
  puts "Please input the sentence or word to translate"
  input = gets.chomp
  puts piglatin.translate(input)
end
