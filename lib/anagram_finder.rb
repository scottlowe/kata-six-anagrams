class AnagramFinder
  attr_accessor :file_location

  def initialize(words_file_location)
    @file_location = words_file_location
  end

  def load_words
    words = {}
    File.open(@file_location, 'r') do |file|
      while line = file.gets
        word = line.strip.downcase
        words[word] = word
      end
    end
    words
  end

  def analyse
    results = {}
    words = load_words

    words.each_key do |first_word|
      words.each_key do |second_word|
        next unless is_anagram? first_word, second_word

        if results.key? first_word
          results[first_word] << second_word
        else
          results[first_word] = [second_word]
        end

        words.delete second_word
      end
    end

    results.values.delete_if {|anagram_set| anagram_set.size <= 1}
  end

  def is_anagram?(first, second)
    return if first.length != second.length

    first.downcase.chars.select {|c| c}.all? do |char|
      second.downcase.chars.select {|c| c}.include? char
    end
  end
end
