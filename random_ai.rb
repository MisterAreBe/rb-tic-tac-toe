require_relative 'base_ai.rb'

class Random_ai < Base_ai

    def place_random()
        temp = Array.new(@board.size) {|i| i}
        while true
            x = temp.sample; y = temp.sample
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
    end

    def move()
        place_random()
    end
end