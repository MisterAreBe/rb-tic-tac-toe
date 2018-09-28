require_relative 'base_ai.rb'

class Random_ai < Base_ai

    def place_random()
        random_spot = []
        temp = @board.grid
        temp.each_with_index do |row, i|
            row.each_with_index do |v, ii|
                if v == ''
                    random_spot << [i, ii]
                end
            end
        end
        while true
            z = random_spot.sample
            if z.is_a?(Array)
                if @board.check_place(z[0], z[1])
                    return place_piece(z[0], z[1])
                end
            else
                break
            end
        end
    end

    def move()
        place_random()
    end
end