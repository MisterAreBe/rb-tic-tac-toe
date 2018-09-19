require "minitest/autorun"
require_relative "../random_ai.rb"

class RandomAi < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_random_ai
        temp = Random_ai.new('o', '')
        assert_equal(Random_ai, temp.class)
    end

    def test_inheritence
        temp = Random_ai.new('x', '')
        assert_equal('x',temp.piece)
    end

    def test_place_piece
        board = Game_board.new(3)
        player = Random_ai.new('o', board)
        player.place_piece(2,0)
        assert_equal(['o', '', ''], board.grid[2])
    end

end