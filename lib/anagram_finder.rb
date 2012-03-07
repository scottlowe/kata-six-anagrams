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
    load_words.values.group_by {|w| w.chars.sort * ''}.values.delete_if {|set| set.size <= 1}
  end

end
