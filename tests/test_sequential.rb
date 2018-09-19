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

end