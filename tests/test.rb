require "minitest/autorun"
require_relative "../tic-tac-toe.rb"

class TicTacToe < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_grid_is_array
        temp = Game_board.new
        assert_equal(Array, temp.grid.class)
    end

    def test_grid_element_is_array
        temp = Game_board.new
        assert_equal(Array, temp.grid[0].class)
    end

    def test_grid_length_is_3
        temp = Game_board.new
        assert_equal(3, temp.grid.length)
    end

    def test_add_to_grid
        temp = Game_board.new
        temp.place('x', 0, 0)
        assert_equal('x', temp.grid[0][0])
    end
end