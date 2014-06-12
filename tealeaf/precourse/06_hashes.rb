#exercise 1
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
immediate_family = family.select {|k, v| k == :sisters || k == :brothers}

arr = immediate_family.values.flatten

p arr
#exercise 2
a = {spring: "warm", summer: "hot"}
b = {fall: "cool", winter: "cold"}

puts a.merge(b)
puts a.merge!(b)
#exercise 3
a = {spring: "warm", summer: "hot"}
a.each_key {|k| puts k}
a.each_value {|v| p v}
a.each {|k, v| puts "#{k} is very #{v}!"}
#exercise 6
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
result = {}

words.each do |word|
  key = word.split('').sort.join
  if result.has_key?(key)
  	result[key].push(word)
  else
  	result[key]=[word]
  end
end

result.each do |k, v|
  puts "........."
  p v
end



