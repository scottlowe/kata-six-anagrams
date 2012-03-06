class AnagramFinder
  def is_anagram?(first, second)
    first_chars  = first.chars.select {|c| c}
    second_chars = second.chars.select {|c| c}
    first_chars.all? {|char| second_chars.include? char }
  end
end
