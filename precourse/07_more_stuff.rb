#exercise 1
def check(words)
  if words =~ /lab/i#plus i then no matter cap or not
  	puts words
  else
  	puts "No match."
  end
end

check("laboratory")
check("experiment")
check("Pans Labyrinth")
check("elaborate")
check("polar bear")
#exercise 2
def execute(&block)
  block #.call(to execute this)
end

execute { puts "Hello from inside the execute method!" }