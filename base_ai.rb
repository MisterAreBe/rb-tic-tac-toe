require_relative "game_board.rb"

class Base_ai
    def initialize(symbol, board)
        @piece = symbol
        @board = board
    end

    def place_piece(x, y)
        @board.place(@piece, x, y)
    end

    attr_reader :piece
end