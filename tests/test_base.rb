require "minitest/autorun"
require_relative "../base_ai.rb"

class TicTacToe < Minitest::Test

    def test_assert_that_1_equals_1
        assert_equal(1, 1)
    end

    def test_class_is_base
        temp = Base_ai.new
        assert_equal(Base_ai, temp.class)
    end

end