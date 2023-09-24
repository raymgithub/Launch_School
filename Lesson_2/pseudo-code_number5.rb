#a method that takes two arrays of numbers and returns the result of merging the arrays. The elements of the first array should become the elements at the even indexes of the returned array, while the elements of the second array should become the elements at the odd indexes. For instance: 

GET first array numbers
GET second array of numbers
Merge first array with second array
Second Array should be added to first array at the odd index without removing any elements in the first array

START
GET first_array
GET second_array

while first_array is not empty
  push first_array elements to second_array starting at index [1]
  increase index count by 2 then add the next element until first_array is empty
end
   

END