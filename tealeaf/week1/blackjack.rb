#problem
#not to repeat action when dealer or player = 21
#deck, card, dealer, player
#calculate total 
#"A" = 11 or 1, "J"/"Q"/"K" = 10
def total(cards)
  arr = cards.map {|e| e[1]} 

  total = 0
  arr.each do |v|
    if v == "A"    
      total += 11
    elsif v.to_i == 0
      total += 10
    else
      total += v.to_i
    end
  end

  arr.select {|e| e == "A"}.count.times do 
    total -= 10 if total > 21 
  end

  total 
end
#start
puts "Welcom to blackjack! Start the game!"

suits = ["H", "D", "S", "C"]
cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

deck = suits.product(cards)
deck.shuffle!
#deal cards
mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

mytotal = total(mycards)
dealertotal = total(dealercards)
#show cards
puts "Dealer has:#{dealercards[0]} and #{dealercards[1]}, total is #{dealertotal}."
puts "You have:#{mycards[0]} and #{mycards[1]}, total is #{mytotal}."
puts "------------ "
#player turn
#total =, >, < 21
#hit or stay
if mytotal == 21
  puts "You hit blackjack. Congradulations!"
  sleep 1
  exit
end

while mytotal < 21
  puts "What do you want to do now? 1.hit 2.stay"
  ans = gets.chomp
  if !["1", "2"].include?(ans)
    puts "Error, please enter 1 or 2."
    next
  end
  if ans == "2"
    puts "You choose to stay!"
    break
  end

  new_cards = deck.pop
  puts "Dealing new card to player:#{new_cards}"
  mycards << new_cards
  mytotal = total(mycards)
  puts "Now you have the total of #{mytotal}."

  if mytotal == 21
    puts "You hit blackjack. Congradulations!"
  end
  if mytotal > 21
    puts "Sorry, you lose."
    exit
  end
end
#dealer turn
#total =, >, < 21
#total at least 17
if dealertotal == 21
  puts "Sorry, dealer wins!You lose."
end

while dealertotal < 17
  new_cards = deck.pop
  puts "Dealing new card to dealer:#{new_cards}"
  dealercards << new_cards
  dealertotal = total(dealercards)
  puts "Now dealer total is #{dealertotal}."

  if dealertotal == 21
    puts "Sorry, dealer wins!You lose."
  elsif dealertotal > 21
    puts "Dealer busted, you win!"
  end
end
#compare hands
puts "Dealer's cards:"
dealercards.each do |card|
  puts "----#{card}----"
end

puts "Player's cards:"
mycards.each do |card|
  puts "----#{card}----"
end

if dealertotal > mytotal
  puts "Sorry, dealer wins!You lose."
elsif dealertotal < mytotal
  puts "Hehe, you win!"
else
  puts "It's a tie."
end

exit
 