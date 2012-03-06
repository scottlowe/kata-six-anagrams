require 'spec_helper'
require 'fakefs/spec_helpers'

describe WordListAnalyser do
  include FakeFS::SpecHelpers
  before(:all) do
    @dupes = %w{one Three Two three four three Five one six Six}
    @anagrams = %w{Miles dog peek dummy keep Limes god Smile Slime dummy}
  end

  context "#load_words" do
    before(:each) do
      FileUtils.mkdir_p('/tmp')

      File.open('/tmp/dupes.txt', 'w') do |f|
        @dupes.each {|word| f.write "#{word}\n"}
      end
    end

    subject { @analyser = WordListAnalyser.new("/tmp/dupes.txt") }

    it "should load words into an Enumerable" do
      subject.load_words.should be_kind_of(Enumerable)
    end

    it "should not contain dupes" do
      subject.load_words.count.should == 6
    end
  end

  context "#analyse" do
    before(:each) do
      FileUtils.mkdir_p('/tmp')

      File.open('/tmp/anagrams.txt', 'w') do |f|
        @anagrams.each {|word| f.write "#{word}\n"}
      end
    end

    subject { WordListAnalyser.new("/tmp/anagrams.txt").analyse }

    it "should return an Enumerable" do
      subject.should be_kind_of(Enumerable)
    end

    it "should only contain a word once in it's output" do
      all_words = subject.flatten
      uniq_words = subject.flatten.uniq
      all_words.count.should == uniq_words.count
    end

    it "should not contain words that are not anagrams" do
      subject.flatten.include?("dummy").should_not be_true
    end

    it "should contain real sets of anagrams" do
      subject.include?(["miles", "limes", "smile", "slime"]).should be_true
    end
  end

end

