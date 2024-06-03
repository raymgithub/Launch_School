require 'pry'

def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    cleanup = word.delete('^A-Za-z')
    counts[cleanup.size] += 1
  end
  p counts.sort.to_h
end


word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
word_sizes('') == {}