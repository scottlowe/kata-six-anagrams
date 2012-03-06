class WordListAnalyser
  attr_accessor :file_location

  def initialize(words_file_location)
    @file_location = words_file_location
  end

  def load_words
    words = []

    File.open(@file_location, 'r') do |file|
      while line = file.gets
        words << line.strip.downcase
      end
    end

    Hash[words.map{|w| [w, w]}]
  end

  def analyse
    results = {}
    finder = AnagramFinder.new
    words = load_words

    words.each_key do |first_word|
      words.each_key do |second_word|
        next unless finder.is_anagram?(first_word, second_word)# && first_word != second_word

        if results.key? first_word
          results[first_word] << second_word
        else
          results[first_word] = [second_word]
        end

        words.delete second_word
      end
    end

    results.values.reject {|anagram_set| anagram_set.size <= 1}
  end
end
