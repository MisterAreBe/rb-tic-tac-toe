require_relative 'base_ai.rb'

class Sequential_ai < Base_ai

    def place_sequential()
        x = 0; y = 0
        while true
            if y < 2 && y >= 0
                y += 1
            elsif y == 2
                y = 0
                x += 1
            end
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
    end

end