require "minitest/autorun"
require_relative "../tic-tac-toe.rb"

class TicTacToe < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_grid_is_array
        temp = Game_board.new(3)
        assert_equal(Array, temp.grid.class)
    end

    def test_grid_element_is_array
        temp = Game_board.new(3)
        assert_equal(Array, temp.grid[0].class)
    end

    def test_grid_length_is_3
        temp = Game_board.new(3)
        assert_equal(3, temp.grid.length)
    end

    def test_add_to_grid
        temp = Game_board.new(3)
        temp.place('x', 0, 0)
        assert_equal('x', temp.grid[0][0])
    end

    def test_add_to_end_of_grid
        temp = Game_board.new(3)
        temp.place('x', 2, 2)
        assert_equal('x', temp.grid[2][2])
    end

    def test_two_moves_filled
        temp = Game_board.new(3)
        temp.place('o', 1, 2)
        temp.place('x', 1, 1)
        assert_equal([['', '', ''], ['', 'x','o'], ['', '','']], temp.grid)
        # temp.grid.each do |v|
        #     p v
        # end
    end

    def test_overwrite_moves
        temp = Game_board.new(3)
        temp.place('o', 1, 0)
        temp.place('x', 0, 2)
        temp.place('o', 0, 2)
        assert_equal([['', '', 'x'], ['o', '', ''], ['', '', '']], temp.grid)
        # temp.grid.each do |v|
        #     p v
        # end
    end

    def test_board_size
        temp = Game_board.new(3)
        assert_equal(3, temp.grid.length)
        assert_equal(3, temp.grid[0].length)
    end

    def test_winner_in_first_row
        temp = Game_board.new(3)
        temp.place('x', 0, 0)
        temp.place('x', 0, 1)
        temp.place('x', 0, 2)
        assert_equal('x', temp.winner_is?())
    end

    def test_winner_in_first_collum
        temp = Game_board.new(3)
        temp.place('o', 0, 0)
        temp.place('o', 1, 0)
        temp.place('o', 2, 0)
        # temp.grid.each do |v|
        #     p v
        # end
        assert_equal('o', temp.winner_is?())
    end

    def test_winner_in_another_collum
        temp = Game_board.new(3)
        temp.place('Mr.popo', 0, 2)
        temp.place('Mr.popo', 1, 2)
        temp.place('Mr.popo', 2, 2)
        # temp.grid.each do |v|
        #     p v
        # end
        assert_equal('Mr.popo', temp.winner_is?())
    end

    def test_winner_diagonally
        temp = Game_board.new(3)
        temp.place('x', 0, 0)
        temp.place('x', 1, 1)
        temp.place('x', 2, 2)
        temp.grid.each do |v|
            p v
        end
        assert_equal('x', temp.winner_is?())
    end


end