#a method that determines the index of the 3rd occurrence of a given character in a string. For instance, if the given character is 'x' and the string is 'axbxcdxex', the method should return 6 (the index of the 3rd 'x'). If the given character does not occur at least 3 times, return nil. 

Iterate through string
If a character is repeated
  -add to a count
If any given character is repeated more than 3 times 
  -return the index of the 3rd character
If any given character is not repeated more than 3 times
  -return nil
PRINT the index of the 3rd character
  