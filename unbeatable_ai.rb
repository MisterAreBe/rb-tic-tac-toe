require_relative 'base_ai.rb'

class Unbeatable_ai < Base_ai

    def win_move()
        # horizontal win
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
                    if @board.check_place(x, y)
                        return place_piece(x, y)
                    end
                end
            end
        end
        # vertical win
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
                if @board.check_place(x, y)
                    return place_piece(x, y)
                end
            end
            collum += 1
        end
        # diagonal L-R
        row = 0; collum = 0; counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1; collum += 1; counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
        # diagonal R-L
        row = 0; collum = 2; counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1; collum -= 1; counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
        false
    end
    
    def block_move()
        # horizontal block
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
                    if @board.check_place(x, y)
                        return place_piece(x, y)
                    end
                end
            end
        end
        # vertical block
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
                if @board.check_place(x, y)
                    return place_piece(x, y)
                end
            end
            collum += 1
        end
        # diagonal block L-R
        row = 0; collum = 0; counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1; collum += 1; counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
        # diagonal block R-L
        row = 0; collum = 2; counter = 0
        temp = Hash.new
        temp['taken'] = []; temp['grab'] = []
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            else
                temp['grab'] << [row, collum]
            end
            row += 1; collum -= 1; counter += 1
        end
        if temp['taken'].length == 2 && temp['grab'].length == 1
            x = temp['grab'][0][0]; y = temp['grab'][0][1]
            if @board.check_place(x, y)
                return place_piece(x, y)
            end
        end
        false
    end

    def fork_move()
        temp = Hash.new
        temp['mine'] = []; temp['blank'] = []; temp['holdmine'] = []; temp['options'] = []
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |tile, ii|
                if tile == @piece
                    temp['mine'] << [i, ii]
                elsif tile == ''
                    temp['blank'] << [i, ii]
                end
            end
            if temp['mine'].length == 1 && temp['blank'].length == 2
                temp['holdmine'] << temp['mine'][0]
                temp['options'] << temp['blank'][0]; temp['options'] << temp['blank'][1]
                if temp['holdmine'].length == 2
                    x = temp['holdmine'][0][0]
                    y = temp['holdmine'][1][0]
                    if @board.check_place(x, y)
                        #p "i try to fork u"
                        return place_piece(x, y)
                    end
                end
            end
            temp['mine'] = []; temp['blank'] = []
        end
        false
    end

    def block_fork()
        temp = Hash.new
        temp['mine'] = []; temp['enemies'] = []; temp['blank'] = []
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |tile, ii|
                if tile != @piece && tile != ''
                    temp['enemies'] << [i, ii]
                elsif tile == @piece
                    temp['mine'] << [i, ii]
                else
                    temp['blank'] << [i, ii]
                end
            end
        end
        if temp['mine'].length > 0 && temp['enemies'].length > 1
            temp['blank'].each do |v|
                if temp['enemies'][0] == [0, 1] && temp['enemies'][1] == [1, 0] && @board.check_place(0, 0)
                    return place_piece(0, 0)
                elsif temp['enemies'][0] == [1, 0] && temp['enemies'][1] == [2, 1] && @board.check_place(2, 0)
                    return place_piece(2, 0)
                elsif temp['enemies'][0] == [1, 2] && temp['enemies'][1] == [2, 1] && @board.check_place(2, 2)
                    return place_piece(2, 2)
                elsif temp['enemies'][0] == [0, 1] && temp['enemies'][1] == [1, 2] && @board.check_place(0, 2)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [2, 2] && @board.check_place(0, 2)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [2, 2] && @board.check_place(2, 0)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [2, 0] && @board.check_place(0, 0)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [2, 0] && @board.check_place(2, 2)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [0, 2] && @board.check_place(0, 0)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [0, 2] && @board.check_place(2, 2)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [0, 0] && @board.check_place(0, 2)
                    return place_piece(0, 2)
                elsif temp['enemies'][0] == [1, 1] && temp['enemies'][1] == [0, 0] && @board.check_place(2, 0)
                    return place_piece(0, 2)
                end
                if v == [(temp['mine'][0][0])-1, temp['mine'][0][1]] && @board.check_place(temp['mine'][0][0]+1, temp['mine'][0][1])
                    return place_piece(v[0], v[1])
                elsif v == [temp['mine'][0][0]+1, temp['mine'][0][1]] && @board.check_place(temp['mine'][0][0]-1, temp['mine'][0][1])
                    return place_piece(v[0], v[1])
                elsif v == [temp['mine'][0][0], temp['mine'][0][1]-1] && @board.check_place(temp['mine'][0][0], temp['mine'][0][1]+1)
                    return place_piece(v[0], v[1])
                elsif v == [temp['mine'][0][0], temp['mine'][0][1]+1] && @board.check_place(temp['mine'][0][0], temp['mine'][0][1]-1)
                    return place_piece(v[0], v[1])
                end
            end
        end
        false
    end

    def center_move()
        center = @board.size/2
        if @board.check_place(center, center)
            return place_piece(center, center)
        end
        false
    end

    def opposite_corner()
        temp = Hash.new(); temp['enemy'] = []
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |v, ii|
                if v != @piece && v != ''
                    if i == 0 || i == 2 && ii == 0 || ii == 2
                        temp['enemy'] << [i, ii]
                    end
                end
            end
        end
        if temp['enemy'].length > 0
            temp['enemy'].each do |v|
                if v[0] == 0 && v[1] == 0
                    if @board.check_place(2, 2)
                        return place_piece(2, 2)
                    end
                elsif v[0] == 0 && v[1] == 2
                    if @board.check_place(2, 0)
                        return place_piece(2, 0)
                    end
                elsif v[0] == 2 && v[1] == 0
                    if @board.check_place(0, 2)
                        return place_piece(0, 2)
                    end
                elsif v[0] == 2 && v[1] == 2
                    if @board.check_place(0, 0)
                        return place_piece(0, 0)
                    end
                end
            end
        end
        false
    end

    def empty_corner()
        if @board.check_place(0, 0)
            return place_piece(0, 0)
        elsif @board.check_place(0, 2)
            return place_piece(0, 2)
        elsif @board.check_place(2, 0)
            return place_piece(2, 0)
        elsif @board.check_place(2, 2)
            return place_piece(2, 2)
        else
            false
        end
    end

    def empty_side()
        if @board.check_place(0, 1)
            return place_piece(0, 1)
        elsif @board.check_place(1, 0)
            return place_piece(1, 0)
        elsif @board.check_place(1, 2)
            return place_piece(1, 2)
        elsif @board.check_place(2, 1)
            return place_piece(2, 1)
        else
            false
        end
    end

    def smart_move()
        unless win_move()
            unless block_move()
                unless fork_move()
                    unless block_fork()
                        unless center_move()
                            unless opposite_corner()
                                unless empty_corner()
                                    unless empty_side()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    def move()
        smart_move()
    end
end