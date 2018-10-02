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

    def test_fails_at_last_move
        board = Game_board.new(3)
        player1 = Base_ai.new('x', board)
        player2 = Sequential_ai.new('o', board)
        player1.place_piece(0,0)
        player2.move()
        player1.place_piece(0,2)
        player2.move()
        player1.place_piece(1,1)
        player2.move()
        player1.place_piece(2,1)
        player2.move()
        player1.place_piece(2,2)
        assert_equal([['x','o','x'],['o','x','o'],['o','x','x']], board.grid)
        board.reset()
        player1 = Base_ai.new('x', board)
        player2 = Sequential_ai.new('o', board)
        x = 0; y = 0
        while board.winner_is?() == false
            player1.place_piece(x, y)
            if board.winner_is? != false
                break
            end
            player2.move()
            if x == 0 && y == 0
                y = 2
            elsif x == 0 && y == 2
                x = 1; y = 1
            elsif x == 1 && y == 1
                x = 2; y = 1
            elsif x == 2 && y == 1
                y = 2
            end
        end
        assert_equal('x', board.winner_is?())
    end
    
end