require_relative "game_board.rb"

class Base_ai
    def initialize(symbol, board)
        @piece = symbol
        @board = board
    end

    def place_piece(x, y)
        if @board.check_place(x,y)
            @board.place(@piece, x, y)
        else
            return false
        end
    end


    attr_reader :piece
end