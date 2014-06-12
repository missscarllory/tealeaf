#exercise 1
puts "What's your name?"
name = gets.chomp
puts "Hello, #{name}"
puts "Hello," + name
#exercise 3
10.times do 
  puts name
end
#exercise 2
puts "How old are you now?"
age = gets.chomp.to_i
puts "In 10 years you will be: #{age + 10}"
puts "In 20 years you will be:"
puts age + 20
puts "In 30 years you will be:"
puts age + 30
puts "In 40 years you will be:"
puts age + 40
#exercise 4
puts "What's your first name?"
first_name = gets.chomp
puts "What's your last name?"
last_name = gets.chomp
puts "Welcome, #{first_name} #{last_name}."
