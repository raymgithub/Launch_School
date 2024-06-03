require 'pry'

def cleanup(string)
  alphanumeric = ('a'..'z').to_a

  cleanedup = []
  
  string.chars.each do |char|
    if alphanumeric.include?(char)
      cleanedup << char
    else
      cleanedup << ' ' unless cleanedup.last == ' '
    end
  end


cleanedup.join
end

# OR

def cleanup_verisontwo(text)
  text.gsub(/[^a-z]/, ' ').squeeze(' ')
end


cleanup("---what's my +*& line?") == ' what s my line '
cleanup_verisontwo("---what's my +*& line?") == ' what s my line '