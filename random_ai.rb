require_relative 'base_ai.rb'

class Random_ai < Base_ai

    def place_random()
        temp = Array.new(@board.size) {|i| i}
        x = temp.sample; y = temp.sample
        until place_piece(x,y)
            x = temp.sample; y = temp.sample
        end
    end

end