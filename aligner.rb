class Aligner
attr_accessor :input_strings
attr_accessor :concatenated

def self.overlap(str1, str2)
  best = 0
  comparisons = [str1.length, str2.length].max
  complength = [str1.length, str2.length].min
  initial = comparisons - complength
  initial.upto(comparisons - 1) do |i|
    x = complength - (i - initial)
    if str1[i,x] == str2[0,x]
      return x
    end
  end
  best
end

  def self.concatenate(str1, str2)
    string_overlap = overlap(str1, str2)
    str1 + str2[string_overlap..-1]
  end
  
  def best_pair
    best = 0
    #return [input_strings.first, input_strings.last] if input_strings.size == 2
    beststr1, beststr2 = input_strings.first, input_strings[1] 
    input_strings.each do |string1|
      (input_strings - [string1]).each do |string2|
        overlap = self.class.overlap(string1, string2)
        if overlap > best
          best = overlap
          beststr1 = string1
          beststr2 = string2
        end
      end
    end
    [beststr1, beststr2]
  end

  def shortest_common_superstring
    while @input_strings.size > 1
      str1, str2 = best_pair
      new_word = self.class.concatenate(str1, str2)
      @input_strings.delete(str1)
      @input_strings.delete(str2)
      @input_strings << new_word
    end
    @input_strings.first
  end
  
  def initialize(fname = nil)
    @input_strings = []
    unless fname.nil?
      wordfile = File.open(fname, "r+")
      wordfile.readlines.each do |line|
        @input_strings << line.strip
      end
    end
  end
end
