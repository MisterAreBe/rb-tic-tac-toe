require_relative 'base_ai.rb'

class Unbeatable_ai < Base_ai

    def smart_move()
        # win -start
        @board.grid.each_with_index do |row, i|
            temp = Hash.new
            temp['taken'] = []; temp['grab'] = []
            row.each_with_index do |tile, ii|
                if tile == @piece
                    temp['taken'] << [i, ii]
                else
                    temp['grab'] << [i, ii]
                end
                if temp['taken'].length == 2 && temp['grab'].length == 1
                    x = temp['grab'][0][0]; y = temp['grab'][0][1]
                    return place_piece(x, y)
                end
            end
        end
        
        collum = 0
        while collum < @board.size
            temp = Hash.new
            temp['taken'] = []; temp['grab'] = []
            counter = 0
            while counter < @board.size
                if @board.grid[counter][collum] == @piece
                    temp['taken'] << [counter, collum]
                else
                    temp['grab'] << [counter, collum]
                end
            counter += 1
            end
            if temp['taken'].length == 2 && temp['grab'].length == 1
                x = temp['grab'][0][0]; y = temp['grab'][0][1]
                return place_piece(x, y)
            end
            collum += 1
        end

        row = 0
        collum = 0
        counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1
            collum += 1
            counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            return place_piece(x, y)
        end

        row = 0
        collum = 2
        counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1
            collum -= 1
            counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            return place_piece(x, y)
        end
        # win -stop
        # block -start
        @board.grid.each_with_index do |row, i|
            temp = Hash.new
            temp['taken'] = []; temp['block'] = []
            row.each_with_index do |tile, ii|
                if tile != @piece && tile != ''
                    temp['taken'] << [i, ii]
                else
                    temp['block'] << [i, ii]
                end
                if temp['taken'].length == 2 && temp['block'].length == 1
                    x = temp['block'][0][0]; y = temp['block'][0][1]
                    return place_piece(x, y)
                end
            end
        end

        collum = 0
        while collum < @board.size
            temp = Hash.new
            temp['taken'] = []; temp['block'] = []
            counter = 0
            while counter < @board.size
                if @board.grid[counter][collum] != @piece && @board.grid[counter][collum] != ''
                    temp['taken'] << [counter, collum]
                else
                    temp['block'] << [counter, collum]
                end
            counter += 1
            end
            if temp['taken'].length == 2 && temp['block'].length == 1
                x = temp['block'][0][0]; y = temp['block'][0][1]
                return place_piece(x, y)
            end
            collum += 1
        end

        row = 0
        collum = 0
        counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1
            collum += 1
            counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            return place_piece(x, y)
        end

        row = 0
        collum = 2
        counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1
            collum -= 1
            counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            return place_piece(x, y)
        end
    end

end