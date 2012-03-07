# encoding: UTF-8

require 'spec_helper'
require 'fakefs/spec_helpers'

describe AnagramFinder do
  include FakeFS::SpecHelpers

  before(:all) do
    @dupes    = %w{one Three Two three four three Five one six Six}
    @anagrams = %w{Miles dog peek dummy keep Limes god skating takings Smile Slime dummy tasking}
  end

  describe "#load_words" do
    before(:each) do
      FileUtils.mkdir_p('/tmp')

      File.open('/tmp/dupes.txt', 'w') do |f|
        @dupes.each {|word| f.write "#{word}\n"}
      end
    end

    subject { @analyser = AnagramFinder.new("/tmp/dupes.txt") }

    it "should load words into an Enumerable" do
      subject.load_words.should be_kind_of Enumerable
    end

    it "should not contain dupes" do
      subject.load_words.count.should == 6
    end
  end

  describe "analysis" do
    before(:each) do
      FileUtils.mkdir_p('/tmp')

      File.open('/tmp/anagrams.txt', 'w') do |f|
        @anagrams.each {|word| f.write "#{word}\n"}
      end
    end

    describe "#analyse" do
      subject { AnagramFinder.new("/tmp/anagrams.txt").analyse }

      it "should return an Enumerable" do
        subject.should be_kind_of Enumerable
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
        subject.each.any? { |anagram_group|
          anagram_group.all? {|word| %w{miles limes smile slime}.include? word}
        }.should be_true
      end
    end

    describe "Statistics" do
      subject { AnagramFinder.new("/tmp/anagrams.txt") }

      it "#longest_anagram_set should return the longest set of anagrams" do
        subject.longest_anagram_set.all? { |word|
          %w{miles limes smile slime}.include? word
        }.should be_true
      end

      it "#longest_anagram_words should return a collection of longest anagrams words" do
        subject.longest_anagram_words.all? { |word|
          %w{skating takings tasking}.include? word
        }.should be_true
      end

    end
  end

end

