# encoding: UTF-8

require 'spec_helper'

describe AnagramFinder do
  describe "#is_anagram?" do
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
end
