require_relative 'base_ai.rb'

class Sequential_ai < Base_ai

    def place_sequential()
        x = 0; y = 0
        while true
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
            if y < (@board.size - 1) && y >= 0
                y += 1
            elsif y == (@board.size - 1)
                y = 0
                x += 1
            end
        end
    end

    def move()
        place_sequential()
    end
end