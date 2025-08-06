class Game
  def initialize()
    @board = Array.new(3, Array.new(3))
  end

  def print_board
    puts @board.to_s
  end
end