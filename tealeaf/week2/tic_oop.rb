class Square
  attr_accessor :square

	def initialize(s)
		@square = s 
	end

	def empty?
		@square == " "
  end

  def marked(mark)
  	@square = mark
  end

  def to_s
  	@square 
  end
end

class Board
	def initialize
		@board = {}
		(1..9).each {|position| @board[position]= Square.new(" ")}
  end
  
  def draw_b
  	system "clear"
  	puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
	  puts "---------"
	  puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
    puts "---------"
    puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "
  end
  
  def empty_s
  	@board.select {|_, s| s.empty?}.values
  end

  def empty_p
  	@board.select {|_, s| s.empty?}.keys
  end

  def all_picked?
  	empty_s.size == 0
  end

  def mark_square(position, mark)
  	@board[position].marked(mark)
  end

  def winner(mark)
  	winning_lines = 
      [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    
    winning_lines.each do |line|
      return true if @board[line[0]].square == mark and @board[line[1]].square == mark and @board[line[2]].square == mark
    end
    false
  end
end

class Player
	attr_accessor :name, :mark

	def initialize(n)
		@name = n
		@mark = []
	end
end

class Computer
  attr_accessor :name, :mark

  def initialize
    @name = "Computer"
    @mark = []
  end
end

class Game
  def initialize
    @board = Board.new
    @you = Player.new("Player")
    @computer = Computer.new
    @current_player = @you
  end
	
	def game_set
		puts "\nWhat's your name?"
		@you.name = gets.chomp
		puts "\nChoose X or O, please."
		@you.mark = gets.chomp.to_s 
     if @you.mark == "X"
       @computer.mark == "O"
     elsif @you.mark == "O"
       @computer.mark == "X"
     end 
	end

	def pick_s
		if @current_player == @you
			begin
		    puts "\nPick a square #{@board.empty_p}: "
		    position = gets.chomp.to_i
		  end until @board.empty_p.include?(position)
		else
			position = @board.empty_p.sample
		end
    @board.mark_square(position, @current_player.mark)
  end
  
  def alternate_player
  	if @current_player == @you
  		@current_player = @computer
  	else
  		@current_player = @you
  	end
  end

  def current_player_win
    @board.winner(@current_player.mark)
  end

  def play
  	@board.draw_b
    game_set
  	loop do 
      pick_s
  		@board.draw_b
  		if current_player_win
  			puts "\nWinner is #{@current_player.name}!"
  			break
  		elsif @board.all_picked?
  			puts "\nIt's a tie!"
  			break
  		else
        alternate_player
  		end
		end 
		puts "Bye Bye!" 
	end
end

Game.new.play
