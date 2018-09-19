require_relative 'base_ai.rb'

class Sequential_ai < Base_ai

    def place_sequential()
        x = 0; y = 0
        while place_piece(x, y) == false
            if y < 2 && y >= 0
                y += 1
            elsif y == 2
                y = 0
                x += 1
            end
        end
    end
end