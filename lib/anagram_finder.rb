class AnagramFinder

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
    @result ||= load_words.values.group_by {|w| w.chars.sort * ''}.values.delete_if {|set| set.size <= 1}
    @result
  end

  def longest_anagram_set
    analyse.sort_by {|set| set.length}.last
  end

  def longest_anagram_words
    by_length = analyse.flatten.group_by {|x| x.length}
    by_length[by_length.keys.sort.last]
  end

end
