require 'spec_helper'

describe AnagramFinder do
  describe "#is_anagram?" do
    context "when two words are the same length" do
      it "should return true when the words are identical" do
        subject.is_anagram?("hello", "hello").should be_true
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
      it "should return false when the words are nearly the same, but for an extra last character on the second word" do
        subject.is_anagram?("hello", "hellox").should be_false
      end

      it "should return false when the words are nearly the same, but for an extra first character on the second word" do
        subject.is_anagram?("hello", "xhello").should be_false
      end

      it "should return false when the words are nearly the same, but for an extra first character on the first word" do
        subject.is_anagram?("xhello", "hello").should be_false
      end

      it "should return false when the words are nearly the same, but for an extra second character on the first word" do
        subject.is_anagram?("hellox", "hello").should be_false
      end
    end
  end
end