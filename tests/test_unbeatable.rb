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


end