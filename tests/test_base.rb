require "minitest/autorun"
require_relative "../base_ai.rb"

class TicTacToe < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_base
        temp = Base_ai.new('')
        assert_equal(Base_ai, temp.class)
    end

    def test_class_is_string
        temp = Base_ai.new('')
        assert_equal(String, temp.piece.class)
    end

    def test_place_piece
        player = Base_ai.new('x')
        board = Game_board.new(3)
        player.place_piece(0, 2)
        assert_equal('x',board.grid[0][2])
    end


end