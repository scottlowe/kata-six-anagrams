# encoding: UTF-8

require 'spec_helper'
require 'fakefs/spec_helpers'

describe AnagramFinder do
  include FakeFS::SpecHelpers

  before(:all) do
    @dupes    = %w{one Three Two three four three Five one six Six}
    @anagrams = %w{Miles dog peek dummy keep Limes god Smile Slime dummy}
  end

  describe "#is_anagram?" do
    subject { @analyser = AnagramFinder.new("/tmp/dupes.txt") }

    context "when two words are the same length" do
      it "should return true when the words are ASCII and identical" do
        subject.is_anagram?("hello", "hello").should be_true
      end

      it "should return true when the words are the same but of different case" do
        subject.is_anagram?("Hello", "helLo").should be_true
      end

      it "should return true when the words contain double-byte chars and are identical" do
        subject.is_anagram?("café", "café").should be_true
      end

      it "should return true when the words contain the same characters in a different order" do
        subject.is_anagram?("hello", "elolh").should be_true
      end

      it "should return false when the words contain some different characters" do
        subject.is_anagram?("hello", "booth").should be_false
      end

      it "should return false when the words all characters are different" do
        subject.is_anagram?("hello", "xgpbt").should be_false
      end
    end

    context "when two words are a different length" do
      it "should return false when second word contains the first, with extra last character on the second" do
        subject.is_anagram?("hello", "hellox").should be_false
      end

      it "should return false when second word contains the first, with extra first character on the second" do
        subject.is_anagram?("hello", "xhello").should be_false
      end

      it "should return false when second word contains the first, with extra first character on the first" do
        subject.is_anagram?("xhello", "hello").should be_false
      end

      it "should return false when second word contains the first, with extra last character on the first" do
        subject.is_anagram?("hellox", "hello").should be_false
      end
    end
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

  describe "#analyse" do
    before(:each) do
      FileUtils.mkdir_p('/tmp')

      File.open('/tmp/anagrams.txt', 'w') do |f|
        @anagrams.each {|word| f.write "#{word}\n"}
      end
    end

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
      subject.include?(["miles", "limes", "smile", "slime"]).should be_true
    end
  end

end

