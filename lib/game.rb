# frozen_string_literal: true

require 'colorize'

class Game
  SIZE = 3

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE, ' ') }
    @current_player = 0
    @players = [Player.new(self, 'X'.colorize(:red)), Player.new(self, 'O'.colorize(:blue))]
  end

  def play
    won = false
    9.times do
      row_num, col_num = @players[@current_player].select_space
      mark_space!(row_num, col_num)

      won = true if three_in_row?(row_num, col_num)
      break if won

      switch_player!
    end

    print_board

    if won
      puts "#{@players[@current_player].marker} wins!"
    else
      puts "It's a draw!"
    end
  end

  def switch_player!
    @current_player = (@current_player + 1) % 2
  end

  def three_in_row?(row_num, col_num)
    marker = @players[@current_player].marker

    # check horizontal
    row = @board[row_num]
    return true if row.all? { |space| space == marker }

    # check vertical
    col = (0...SIZE).map { |i| @board[i][col_num] }
    return true if col.all? { |space| space == marker }

    # check diagonals
    if row_num == col_num
      diag = (0...SIZE).map { |i| @board[i][i] }
      return true if diag.all? { |space| space == marker }

    elsif row_num == SIZE - 1 - col_num
      diag = (0...SIZE).map { |i| @board[i][SIZE - 1 - i] }
      return true if diag.all? { |space| space == marker }
    end

    false
  end

  def mark_space!(row_num, col_num)
    @board[row_num][col_num] = @players[@current_player].marker
  end

  def space_free?(row_num, col_num)
    row_num.between?(0, SIZE - 1) && col_num.between?(0, SIZE - 1) && @board[row_num][col_num] == ' '
  end

  def print_board
    row_strs = @board.map { |row| row.join(' | ') }
    puts row_strs.join("\n---------\n")
  end
end
