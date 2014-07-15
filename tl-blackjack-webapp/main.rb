require 'rubygems'
require 'sinatra'

set :sessions, true

enable :sessions
set :session_secret, 'anne'

BLACK_MAX = 21
BLACK_MIN = 17

helpers do 
  def calculate_total(cards)
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
      total -= 10 if total > BLACK_MAX
    end
    total 
  end

  def card_image(cards)
    suit = case cards[0]
      when 'H' then 'hearts'
      when 'C' then 'clubs'
      when 'D' then 'diamonds'
      when 'S' then 'spades'
    end

    value = cards[1]
    if ['J', 'Q', 'K', 'A'].include?(value)
      value = case cards[1]
        when 'J' then 'jack'
        when 'Q' then 'queen'
        when 'K' then 'king'
        when 'A' then 'ace'
      end
    end

    "<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'>"
  end

  def win!(msg)
    @play_again = true
    @show_hit_or_stay = false
    @welcome = false
    win_bet
    @success = "<strong>YEAH!!! #{session[:player_name]} won! #{msg} You got $#{session[:amount]}!!!</strong>"
  end

  def lose!(msg)
    @play_again = true
    @show_hit_or_stay = false
    @welcome = false
    lose_bet
    @error = "<strong>Sorry, #{session[:player_name]} lost! #{msg} OHOH, now you only have $#{session[:amount]}.</strong>"
  end

  def tie!(msg)
    @play_again = true
    @show_hit_or_stay = false
    @welcome = false
    @success = "<strong>It's a tie... #{msg} You still have $#{session[:amount]}...</strong>"
  end

  def win_bet
    session[:amount] += session[:bet_number].to_i
  end

  def lose_bet
    session[:amount] -= session[:bet_number].to_i
  end
  
end

before do 
  @show_hit_or_stay = true
end

before do 
  @welcome = true
end

before do 
  @broke = false
end

get '/' do
  if session[:player_name] 
    redirect '/bet'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  session[:amount] = 500
  erb :new_player
end

post '/new_player' do
  if params[:player_name].empty? 
    @error = 'You have to enter your name to start the game.'
    halt erb(:new_player)
  end

  session[:player_name] = params[:player_name]
  redirect '/bet'
end

get '/bet' do
  if session[:amount] == 0
    redirect '/game_over'
  end
  erb :bet
end

post '/bet' do
  if params[:bet_number].empty?
    @error = 'You have to make a bet.'
    halt erb(:bet)
  elsif params[:bet_number].to_i > session[:amount] || params[:bet_number].to_i <= 0 
    @error = 'Enter a valid number.'
    halt erb(:bet)
  end
  
  session[:bet_number] = params[:bet_number]
  redirect '/game'
end


get '/game' do
  session[:turn] = session[:player_name]
  #create a deck 
  suits = ["H", "D", "S", "C"]
  cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
  session[:deck] = suits.product(cards).shuffle!
  
  #deal cards
  session[:dealer_card] = []
  session[:player_card] = []
  session[:dealer_card] << session[:deck].pop
  session[:player_card] << session[:deck].pop
  session[:dealer_card] << session[:deck].pop
  session[:player_card] << session[:deck].pop


  erb :game
end

post '/game/player/hit' do
  session[:player_card] << session[:deck].pop

  player_total = calculate_total(session[:player_card])
  if player_total == BLACK_MAX
    win!("#{session[:player_name]} hit blackjack.")
  elsif player_total > BLACK_MAX
    lose!("#{session[:player_name]} is busted at #{player_total}.")
  end 
  erb :game
end

post '/game/player/stay' do
  @success = "#{session[:player_name]} has chosen to stay."
  @show_hit_or_stay = false

  redirect '/game/dealer'
end

get '/game/dealer' do
  session[:turn] = "dealer"
  @show_hit_or_stay = false

  dealer_total = calculate_total(session[:dealer_card])
  if dealer_total > BLACK_MAX
    win!("Dealer busted at #{dealer_total}!")
  elsif dealer_total == BLACK_MAX
    lose!("Dealer hit blackjack.")
  elsif dealer_total >= BLACK_MIN
    redirect '/game/compare'
  else  
    @show_dealer_hit = true
  end    
  erb :game
end

post '/game/dealer/hit' do
  @show_hit_or_stay = false

  session[:dealer_card] << session[:deck].pop
  redirect '/game/dealer'  
end

get '/game/compare' do
  @show_hit_or_stay = false

  player_total = calculate_total(session[:player_card])
  dealer_total = calculate_total(session[:dealer_card])

  if player_total > dealer_total
    win!("#{session[:player_name]} stayed at #{player_total}, and dealer stayed at #{dealer_total}.")
  elsif player_total < dealer_total
    lose!("#{session[:player_name]} stayed at #{player_total}, and dealer stayed at #{dealer_total}.")
  else
    tie!("#{session[:player_name]} and dealer stayed at #{player_total}.")
  end

  erb :game    
end  

get '/game_over' do 
  erb :game_over
end





