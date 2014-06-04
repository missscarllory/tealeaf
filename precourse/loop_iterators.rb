#exercise 2
x = " "
while x != "STOP" do
  puts "How are  you doing?"
  ans = gets.chomp
  puts "Anything to say?"
  x = gets.chomp
end
#exercise 3
top_five_stars = ["Lee An", "Jay Chou", "Mei"]
top_five_stars.each_with_index do |stars, index|
  puts "#{index + 1}, #{stars}"
end
#exercise 4
def count_to_zero(num)
  if num <= 0
    puts num
  else
    puts num
    count_to_zero(num-1)
  end
end

puts count_to_zero(-2)
puts count_to_zero(4)
  		


