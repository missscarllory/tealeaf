#exercise 1
array = [1, 3, 5, 7, 9, 11]
number = 3

if array.include?(num) 
  puts "#{num} is in this array."
end
#or
array.each do |num|
  if num == number
  	puts "#{number} is in this array."
  end
end
#exercise 2
arr = ["b", "a"]
arr = arr.product(Array(1..3))
arr.first.delete(arr.first.last)

arr = ["b", "a"]
arr = arr.product([Array(1..3)])
arr.first.delete(arr.first.last)
#exercise 3
arr = [["test", "hello", "world"],["example", "mem"]]
arr.last.first
arr[1][0]
#exercise 4
arr = [15, 7, 18, 5, 12, 8, 5, 1]
arr.index(5)
=>3
arr.index[5]
arr[5]
=>8
#exercise 5
names = ["Bob", 'May', "Jack"]
names[3] = "Kai"
#names[only integer]
#exercise 6
arr = [1, 2, 3, 4]
new_arr = []

arr.each do |n|
  new_arr << n + 2
end

p arr
p new_arr