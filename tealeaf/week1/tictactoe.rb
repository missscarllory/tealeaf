#draw a board
#ask the name of player and start
#assign player to "X"
#assign computer to "O"
#
#loop until a winner or all squares are taken
#player picks an empty square
#check for a winner
#computer picks an empty square
#check for a winner 
#player picks an empty square
#don't chooose nums that has been chosen

#if there is a winner
#show the winner
#else
#it's a tie
require 'pry'

def initialize_board
  b = {}
  (1..9).each {|position| b[position] = " "}
  b
end

def draw_board(b)
  system "clear"
	puts " #{b[1]} | #{b[2]} | #{b[3]} "
	puts "---------"
	puts " #{b[4]} | #{b[5]} | #{b[6]}"
  puts "---------"
  puts " #{b[7]} | #{b[8]} | #{b[9]}"
end

def empty_positions(b)
  b.select {|k, v| v == " "}.keys
end

def player_picks_square(b)
  puts "Pick a square(1 - 9): "
	player = gets.chomp.to_i
    if b[player] == " "
      b[player] = "X"
    else
      puts "Please enter valid number(1 - 9)"
      player = gets.chomp.to_i
      b[player] = "X"
    end
end

def computer_picks_square(b)
  computer = empty_positions(b).sample
  b[computer] = "O"
end
#binding.pry
def check_winner(b)
  winning_lines = 
    [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  if empty_positions(b).length > 3
    return nil
  else
    winning_lines.each do |line|
      if b[line[0]] == "X" and b[line[1]] == "X" and b[line[2]] == "X"
        return 'player'
      elsif b[line[0]] == "O" and b[line[1]] == "O" and b[line[2]] == "O"
        return 'Computer'
      end
    end
  end
  return nil
end

board = initialize_board
draw_board(board) 
puts "Please enter your name."
name = gets.chomp
puts "Game starts! You are X."

begin 
  player_picks_square(board)
  computer_picks_square(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner 
  puts "#{winner} #{name} won."
else
  puts "It's a tie."
end
