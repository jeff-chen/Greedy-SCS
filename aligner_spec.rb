require 'aligner'

describe "Aligner overlap" do
  it 'should align two words and return the right overlap' do
    Aligner.overlap('abcde', 'cdefg').should == 3
  end

  it 'works even if the input strings are not the same size' do
    Aligner.overlap('aabba', 'abab').should == 1
    Aligner.overlap('abab', 'aabba').should == 0
  end
  it 'does not return anything if there is a left overlap' do
    Aligner.overlap('cdefg', 'abcde').should == 0
  end

  it 'returns an overlap of 0 if there is no overlap' do
    Aligner.overlap('aaaaa', 'bbbbb').should == 0
  end

  it 'returns an overlap of word length if the words are identical' do
    Aligner.overlap('aaaaa', 'aaaaa').should == 5
  end
end

describe "Aligner intersect" do
  it 'concatenates two words by cropping out their letters in common' do
    Aligner.concatenate('abcde', 'cdefg').should == 'abcdefg'
  end

  it 'concatenates two words completely if no overlap' do
    Aligner.concatenate('abcd', 'efgh').should == 'abcdefgh'
  end

  it 'concatenates two words of uneven length' do
    Aligner.concatenate('aabba', 'abab').should == 'aabbabab'
  end
end

describe "Aligner find best words" do
  it 'finds the two words with the most overlap' do
    @aligner = Aligner.new
    @aligner.input_strings = ["aabb", "abab", "abba"]
    @aligner.best_pair.should == ["aabb", "abba"]
  end
  it 'finds the two words if there are only two words' do
    @aligner = Aligner.new
    @aligner.input_strings = ["aabb", "abab"]
    @aligner.best_pair.should == ["aabb", "abab"]
  end
end

describe "Aligner shortest common superstring" do
  before do
    @aligner = Aligner.new
    @aligner.input_strings = ["aabb", "abab", "abba"]
  end

  it 'finds the shortest common superstring using the greedy algorithm' do
    @aligner.shortest_common_superstring.should == "aabbabab"
  end
end
