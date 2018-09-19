require "minitest/autorun"
require_relative "../sequential_ai.rb"

class SequentialAi < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_sequential_ai
        temp = Sequential_ai.new('x', '')
        assert_equal(Sequential_ai, temp.class)
    end

    def test_piece_is_o
        temp = Sequential_ai.new('o', '')
        assert_equal('o', temp.piece)
    end

    def test_place_piece
        board = Game_board.new(3)
        temp = Sequential_ai.new('x', board)
        temp.place_piece(1,1)
        assert_equal('x', board.grid[1][1])
    end

    def test_place_sequential
        board = Game_board.new(3)
        temp = Sequential_ai.new('o', board)
        temp.place_sequential()
        assert_equal('o', board.grid[0][0])
    end

    
end