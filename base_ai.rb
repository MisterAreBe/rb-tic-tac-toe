require_relative "game_board.rb"

class Base_ai
    def initialize(symbol, board)
        @piece = symbol
        @board = board
        @end_point = (@board.size - 1)
    end

    def place_piece(x, y)
        @board.place(@piece, x, y)
    end

    attr_reader :end_point
    attr_reader :piece
end