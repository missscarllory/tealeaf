#exercise 1&2
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each do { |num| puts num if num > 5 }
#exercise 3 
n_arr = arr.select do |num| num.odd? end
#exercise 4
arr.push(11)
arr.unshift(0)
#exercise 5
arr<<(3)
arr.delete(11)
#exercise 6
arr.uniq
arr.uniq!
#exercise 8
names = {:Jay => "handsome", :May => "ugly"}
names = {Jay:"handsome", May:"ugly"}
#exercise 9
h = {a:1, b:2, c:3, d:4}
h[:b]
h[:e] = 5
h.delete_if do |k, v| v < 3.5 end 
#exercise 12
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"][:email] = contact_data[0][0]
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][2]
contacts["Sally Johnson"][:email] = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone] = contact_data[1][2]
#exercise 13
puts "Joe's email is :#{contacts["Joe Smith"][:email]}"
puts "Sally's phone number is: #{contacts["Sally Johnson"][:phone]}"
#exercise 14
contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
fields = [:email, :address, :phone]

contacts.each do |name, hash|
  fields.each do |field|
  	hash[field] = contact_data.shift
  end
end
#exercise 15
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |word| word.start_with?("s", "w") }
arr.delete_if do |word| word.start_with?("s", "w") end#no space
puts arr
#exercise 16
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
# n_arr = a.split (split is for string)
a = a.map! {|w| w.split}
a = a.flatten!
p a
# or a.map!{|w| w.split}.flatten!