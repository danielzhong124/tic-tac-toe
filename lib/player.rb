class Player
  attr_reader :marker

  def initialize(game, marker)
    @game = game
    @marker = marker
  end

  def select_space
    @game.print_board
    puts "#{marker}'s turn."

    print "Select row (0-2): "
    row_num = gets.to_i

    print "Select column (0-2): "
    col_num = gets.to_i

    until @game.space_free?(row_num, col_num) do
      puts "Invalid move. Try again."

      print "Select row (0-2): "
      row_num = gets.to_i

      print "Select column (0-2): "
      col_num = gets.to_i      
    end

    return [row_num, col_num]
  end
end