require_relative 'base_ai.rb'

class Unbeatable_ai < Base_ai

    def smart_move()
        @board.grid.each_with_index do |row,i|
            temp = Hash.new
            temp['taken'] = []
            temp['grab'] = []
            row.each_with_index do |tile,ii|
                if tile == @piece
                    temp['taken'] << [i,ii]
                else
                    temp['grab'] << [i,ii]
                end
                if temp['taken'].length == 2 && temp['grab'].length == 1
                    x = temp['grab'][0][0]; y = temp['grab'][0][1]
                    place_piece(x, y)
                end
            end
        end
    end

end