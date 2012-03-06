class AnagramFinder

  def initialize(words_file_location)
    @file_location = words_file_location
  end

  def load_words
    @words ||= begin
      words = {}
      File.open(@file_location, 'r') do |file|
        while line = file.gets
          word = line.strip.downcase
          words[word] = word
        end
      end
      words
    end
  end

  def analyse
    results = {}
    words = load_words

    words.each_key do |word_1|
      words.each_key do |word_2|
        next unless is_anagram? word_1, word_2

        if results.key? word_1
          results[word_1] << word_2
        else
          results[word_1] = [word_2]
        end

        words.delete word_2
      end
    end

    results.each {|k,v| v << k}.values
  end

  def is_anagram?(first, second)
    return false if first.length != second.length || first == second

    first.downcase.chars.select {|c| c}.all? do |char|
      second.downcase.chars.select {|c| c}.include? char
    end
  end
end
