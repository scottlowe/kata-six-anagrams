class AnagramFinder
  def is_anagram?(first, second)
    return if first.length != second.length

    first.downcase.chars.select {|c| c}.all? do |char|
      second.downcase.chars.select {|c| c}.include? char
    end
  end
end
