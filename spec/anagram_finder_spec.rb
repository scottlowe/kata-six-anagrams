require 'spec_helper'

describe AnagramFinder do
  describe "#is_anagram?" do
    context "when two words are the same length" do

      it "should return true when the words are identical" do
        subject.is_anagram?("hello", "hello").should be_true
      end

      it "should return true when the words not identical" do
        subject.is_anagram?("hello", "booth").should be_false
      end
    end
  end
end