require "minitest/autorun"
require_relative "../base_ai.rb"

class BaseAi < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_base
        temp = Base_ai.new('', '')
        assert_equal(Base_ai, temp.class)
    end

    def test_class_is_string
        temp = Base_ai.new('', '')
        assert_equal(String, temp.piece.class)
    end

    def test_place_piece
        board = Game_board.new(3)
        player = Base_ai.new('x', board)
        player.place_piece(0, 2)
        assert_equal('x',board.grid[0][2])
    end

    def test_end_point
        board = Game_board.new(51)
        player = Base_ai.new('o', board)
        assert_equal(50, player.end_point)
    end


end