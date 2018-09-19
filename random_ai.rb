require_relative 'base_ai.rb'

class Random_ai < Base_ai

    def place_random()
        temp = Array.new(@board.size) {|i| i}
        x = temp.sample; y = temp.sample
        while place_piece(x,y) == false
            x = temp.sample; y = temp.sample
        end
    end

end