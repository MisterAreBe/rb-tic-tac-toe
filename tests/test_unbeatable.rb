require "minitest/autorun"
require_relative "../unbeatable_ai.rb"

class UnbeatableAi < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_unbeatable_ai
        temp = Unbeatable_ai.new('x', '')
        assert_equal(Unbeatable_ai, temp.class)
    end

    def test_piece_is_o
        temp = Unbeatable_ai.new('o', '')
        assert_equal('o', temp.piece)
    end

    def test_place_piece
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        temp.place_piece(0,2)
        assert_equal('x', board.grid[0][2])
    end

    def test_smart_move
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('o', board)
        temp.place_piece(0,0)
        temp.place_piece(0,1)
        temp.smart_move()
        assert_equal(['o', 'o', 'o'], board.grid[0])
        board.reset()
        temp = Unbeatable_ai.new('x', board)
        temp.place_piece(2,0)
        temp.place_piece(2,2)
        temp.smart_move()
        assert_equal(['x', 'x', 'x'], board.grid[2])
    end

    def test_smart_move_vertical_win
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        temp.place_piece(0,0)
        temp.place_piece(1,0)
        temp.smart_move()
        assert_equal([['x','',''],['x','',''],['x','','']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('o', board)
        temp.place_piece(0,1)
        temp.place_piece(1,1)
        temp.smart_move()
        assert_equal([['','o',''],['','o',''],['','o','']], board.grid)
    end

    def test_smart_move_diagonal_left_to_right
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('o', board)
        temp.place_piece(0,0)
        temp.place_piece(1,1)
        temp.smart_move()
        assert_equal([['o','',''],['','o',''],['','','o']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('x', board)
        temp.place_piece(2,2)
        temp.place_piece(0,0)
        temp.smart_move()
        assert_equal([['x','',''],['','x',''],['','','x']], board.grid)
    end

    def test_smart_move_diagonal_right_to_left
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        temp.place_piece(0,2)
        temp.place_piece(1,1)
        temp.smart_move()
        assert_equal([['','','x'],['','x',''],['x','','']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('o', board)
        temp.place_piece(2,0)
        temp.place_piece(0,2)
        temp.smart_move()
        assert_equal([['','','o'],['','o',''],['o','','']], board.grid)
    end

    def test_block_enemy
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('o', board)
        enemy = Base_ai.new('x', board)
        enemy.place_piece(0,0)
        enemy.place_piece(0,1)
        temp.smart_move()
        assert_equal(['x','x','o'], board.grid[0])
        board.reset()
        temp = Unbeatable_ai.new('x', board)
        enemy = Base_ai.new('o', board)
        enemy.place_piece(2,2)
        enemy.place_piece(2,0)
        temp.smart_move()
        assert_equal(['o','x','o'], board.grid[2])
    end

    def test_block_enemy_vertical
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        enemy = Base_ai.new('o', board)
        enemy.place_piece(0,2)
        enemy.place_piece(2,2)
        temp.smart_move()
        assert_equal([['','','o'],['','','x'],['','','o']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('o', board)
        enemy = Base_ai.new('x', board)
        enemy.place_piece(0,1)
        enemy.place_piece(1,1)
        temp.smart_move()
        assert_equal([['','x',''],['','x',''],['','o','']], board.grid)
    end

    def test_block_enemy_diagonal
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('o', board)
        enemy = Base_ai.new('x', board)
        enemy.place_piece(1,1)
        enemy.place_piece(2,2)
        temp.smart_move()
        assert_equal([['o','',''],['','x',''],['','','x']], board.grid)
    end

    def test_block_enemy_diagonal
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        enemy = Base_ai.new('o', board)
        enemy.place_piece(0,2)
        enemy.place_piece(2,0)
        temp.smart_move()
        assert_equal([['','','o'],['','x',''],['o','','']], board.grid)
    end

    def test_make_a_fork
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('o', board)
        enemy = Base_ai.new('x', board)
        temp.place_piece(0,0)
        enemy.place_piece(1,1)
        temp.place_piece(2,2)
        temp.smart_move()
        assert_equal([['o','','o'],['','x',''],['','','o']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('x', board)
        enemy = Base_ai.new('o', board)
        temp.place_piece(1,1)
        enemy.place_piece(0,0)
        temp.place_piece(2,2)
        temp.smart_move()
        assert_equal([['o','',''],['','x','x'],['','','x']], board.grid)
    end

    def test_block_fork
        board = Game_board.new(3)
        temp = Unbeatable_ai.new('x', board)
        enemy = Base_ai.new('o', board)
        enemy.place_piece(0,0)
        temp.place_piece(1,1)
        enemy.place_piece(2,2)
        temp.smart_move()
        assert_equal([['o','x',''],['','x',''],['','','o']], board.grid)
        board.reset()
        temp = Unbeatable_ai.new('o', board)
        enemy = Base_ai.new('x', board)
        enemy.place_piece(2,1)
        temp.place_piece(1,1)
        enemy.place_piece(1,2)
        temp.smart_move()
        assert_equal([['','',''],['','o','x'],['','x','o']], board.grid)
    end


end