#deck, card, dealer, player
#start
puts "Welcom to blackjack!"
sleep 1
puts "Enter your name: "
name = gets.chomp
puts "#{name}  Let's start!"
sleep 1
#cards
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

mytotal = total(mycards)
dealertotal = total(dealercards)
#show cards
puts "\nDealer's cards: total is #{dealertotal}"
dealercards.each do |card|
  puts "----#{card}----"
end

puts "\nPlayer's cards: total is #{mytotal}"
mycards.each do |card|
  puts "----#{card}----"
end

#player turn
#total =, >, < 21
#hit or stay

if mytotal == 21
  puts "You hit blackjack. Congradulations!"
  exit
end

while mytotal < 21
  puts "\nWhat do you want to do now? 1.hit 2.stay"
  ans = gets.chomp
  if !["1", "2"].include?(ans)
    puts "\nError, please enter 1 or 2."
    next
  end
  if ans == "2"
    puts "\nYou choose to stay!"
    break
  end

  new_cards = deck.pop
  puts "\nDealing new card to player:#{new_cards}"
  sleep 1
  mycards << new_cards
  mytotal = total(mycards)
  puts "\nNow you have the total of #{mytotal}."

  if mytotal == 21
    puts "You hit blackjack. Congradulations!"
    exit
  elsif mytotal > 21
    puts "Sorry, you lose."
    exit
  else
    next
  end
end
#dealer turn
#total =, >, < 21
#total at least 17
if dealertotal == 21
  puts "Sorry, dealer wins!You lose."
  exit
end

while dealertotal < 17
  new_cards = deck.pop
  puts "Dealing new card to dealer:"
  sleep 1
  puts "#{new_cards}"
  dealercards << new_cards
  dealertotal = total(dealercards)
  sleep 1
  puts "Now dealer total is #{dealertotal}."

  if dealertotal == 21
    puts "Sorry, dealer wins!You lose."
    exit
  elsif dealertotal > 21
    puts "Dealer busted, you win!"
    exit
  else
    next
  end
end

#compare
if dealertotal > mytotal 
  puts "Sorry, dealer wins!You lose."
elsif dealertotal < mytotal
  puts "Hehe, you win!"
else
  puts "It's a tie."
end

exit 