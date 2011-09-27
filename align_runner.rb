require 'aligner'
t1 = Time.now.to_f
a = Aligner.new("foo.txt")
puts a.shortest_common_superstring
puts (Time.now.to_f - t1)
