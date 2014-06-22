class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end

  def output
    "#{suit}, #{value}"
  end

  def to_s
    output
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ["H", "D", "S", "C"].each do |suit|
      ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    shuffle
  end

  def shuffle
    cards.shuffle!
  end

  def one_card
    cards.pop
  end

end

module Hand
  def total
    value = cards.map {|card| card.value} 

    total = 0
    value.each do |v|
      if v == "A"    
        total += 11
      elsif v.to_i == 0
        total += 10
      else
        total += v.to_i
      end
    end

    value.select {|v| v == "A"}.count.times do 
      total -= 10 if total > Blackjack::MIN
    end
    total 
  end

  def add_card(new_c)
    cards << new_c
  end

  def is_busted?
    total > 21
  end
end

class Player
  include Hand
  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end   

  def show_hand
    puts "\n#{name}'s cards: total is #{total}"
    cards.each do |card|
      puts "----#{card}----"
    end
  end
end

class Dealer
  include Hand
  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "\nDealer's cards: "
    puts "----???----"
    puts "----#{cards[1]}----"
  end
end

class Blackjack
  MIN = 17
  MAX = 21

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("Player")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def game_set 
    puts "Welcome to Blackjack!\nPlease enter your name."
    player.name = gets.chomp
    puts "\nLet's start ~"
  end

  def deal_card
    puts "\nDealing cards..."
    sleep 1
    player.add_card(deck.one_card)
    dealer.add_card(deck.one_card)
    player.add_card(deck.one_card)
    dealer.add_card(deck.one_card)
  end

  def show_card
    player.show_hand
    dealer.show_flop
  end
  
  def hit_or_bust(player_dealer)
    if player_dealer.total == MAX
      if player_dealer.is_a?(Player)
        puts "YEAH!!!#{player.name} hit Blackjack. You win."
      else
        puts "Sorry...dealer hit Blackjack, you loses!"
      end
      play_again?
    elsif player_dealer.is_busted?
      if player_dealer.is_a?(Player)
        puts "Sorry, #{player.name} loses."
      else
        puts "YES! #{player.name} win!"
      end
      play_again?
    end
  end
            
  def player_turn
    sleep 1 
    puts "\nIt's #{player.name}'s' turn."
    hit_or_bust(player)
    
    while !player.is_busted?
      puts "\nDo you want to hit or stay? h)hit s)stay"
      ans = gets.chomp.to_s
      
      if !["h", "s"].include?(ans)
        puts "Enter h or s,please."
        next
      end

      if ans == "s"
        puts "\n#{player.name} stay."
        break
      end
      
      new_c = deck.one_card
      puts "\nDealing new card to player: "
      sleep 1
      puts "---#{new_c}---"
      player.add_card(new_c) 
      puts "\n#{player.name}'s cards: total is #{player.total}"

      hit_or_bust(player)
    end
  end 
  
  def dealer_turn
    sleep 1
    puts "\nIt's dealer's turn."
    hit_or_bust(dealer)

    while dealer.total < MIN
      new_c = deck.one_card
      puts "\nDealing card to dealer: "
      sleep 1
      puts "---#{new_c}---"
      dealer.add_card(new_c)
      puts "\nDealer's cards: total is #{dealer.total}"

      hit_or_bust(dealer)
    end
  end
  
  def check_winner
    if dealer.total < player.total
      puts "Congradulations!#{player.name} win."
    elsif dealer.total > player.total
      puts "Oh oh, #{player.name} lose. Bye."
    else
      puts "It's a tie."
    end  
    play_again?
  end

  def play_again? 
    puts "\nDo you want to play again? 1)yes 2)no"
    ans = gets.chomp.to_i
    
    if [1, 2].include?(ans)
      if ans == 1
        puts "\nStarting new game..."
        sleep 1
        puts " "
        player.cards = []
        dealer.cards = []
        deck = Deck.new
        start 
      else
        puts "\nGoodbye! #{player.name}"
        exit
      end
    else
      puts "\nEnter 1 or 2, please."
      play_again?
    end
  end 
  
  def start
    game_set
    deal_card
    show_card
    player_turn
    dealer_turn
    check_winner
  end
end

game = Blackjack.new
game.start
