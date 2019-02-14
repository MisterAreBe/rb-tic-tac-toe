require_relative 'base_ai.rb'

class Unbeatable_ai_2 < Base_ai

    def win_move()
        method_array = [win_move_horizontal(), win_move_vertical(), win_move_diagonal_l_r(), win_move_diagonal_r_l()]
        method_array.each do |v|
            if v != false
                return v
            end
        end
        false
    end
    
    def check_board(taken, action)
        if taken == @end_point && action.length == 1
            if @board.check_place(action[0][0], action[0][1])
                return place_piece(action[0][0], action[0][1])
            end
        end
        false
    end

    def win_move_horizontal()
        @board.grid.each_with_index do |row, i|
            temp = {'taken' => [], 'grab' => []}
            row.each_with_index do |tile, ii|
                if tile == @piece
                    temp['taken'] << [i, ii]
                elsif tile == ''
                    temp['grab'] << [i, ii]
                end
            end
            if temp['taken'].length == @end_point && temp['grab'].length == 1
                x = temp['grab'][0][0]; y = temp['grab'][0][1]
                return place_piece(x, y)
            end
        end
        false
    end

    def win_move_vertical()
        collum = 0
        while collum < @board.size
            temp = {'taken' => [], 'grab' => []}
            counter = 0
            while counter < @board.size
                if @board.grid[counter][collum] == @piece
                    temp['taken'] << [counter, collum]
                elsif @board.grid[counter][collum] == ''
                    temp['grab'] << [counter, collum]
                end
                counter += 1
            end
            if temp['taken'].length == @end_point && temp['grab'].length == 1
                x = temp['grab'][0][0]; y = temp['grab'][0][1]
                return place_piece(x, y)
            end
            collum += 1
        end
        false
    end

    def win_move_diagonal_l_r()
        row = 0; collum = 0; counter = 0
        temp = {'taken' => [], 'grab' => []}
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            elsif @board.grid[row][collum] ==''
                temp['grab'] << [row, collum]
            end
            row += 1; collum += 1; counter += 1
        end
        return check_board(temp['taken'].length, temp['grab'])
    end

    def win_move_diagonal_r_l()
        row = 0; collum = 2; counter = 0
        temp = {'taken' => [], 'grab' => []}
        while counter < @board.size
            if @board.grid[row][collum] == @piece
                temp['taken'] << [row, collum]
            elsif @board.grid[row][collum] == ''
                temp['grab'] << [row, collum]
            end
            row += 1; collum -= 1; counter += 1
        end
        return check_board(temp['taken'].length, temp['grab'])
    end

    def block_move()
        method_array = [block_move_horizontal(), block_move_vertical(), block_move_diagonal_l_r(), block_move_diagonal_r_l()]
        method_array.each do |v|
            if v != false
                return v
            end
        end
        false
    end

    def block_move_horizontal()
        @board.grid.each_with_index do |row, i|
            temp = {'taken' => [], 'block' => []}
            row.each_with_index do |tile, ii|
                if tile != @piece && tile != ''
                    temp['taken'] << [i, ii]
                elsif tile == ''
                    temp['block'] << [i, ii]
                end
            end
            if temp['taken'].length == @end_point && temp['block'].length == 1
                x = temp['block'][0][0]; y = temp['block'][0][1]
                return place_piece(x, y)
            end
        end
        false
    end

    def block_move_vertical()
        collum = 0
        while collum < @board.size
            temp = {'taken' => [], 'block' => []}
            counter = 0
            while counter < @board.size
                if @board.grid[counter][collum] != @piece && @board.grid[counter][collum] != ''
                    temp['taken'] << [counter, collum]
                elsif  @board.grid[counter][collum] == ''
                    temp['block'] << [counter, collum]
                end
                counter += 1
            end
            if temp['taken'].length == @end_point && temp['block'].length == 1
                x = temp['block'][0][0]; y = temp['block'][0][1]
                return place_piece(x, y)
            end
            collum += 1
        end
        false
    end

    def block_move_diagonal_l_r()
        row = 0; collum = 0; counter = 0
        temp = {'taken' => [], 'block' => []}
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            elsif @board.grid[row][collum] == ''
                temp['block'] << [row, collum]
            end
            row += 1; collum += 1; counter += 1
        end
        check_board(temp['taken'].length, temp['block'])
    end

    def block_move_diagonal_r_l()
        row = 0; collum = @end_point; counter = 0
        temp = {'taken' => [], 'block' => []}
        while counter < @board.size
            if @board.grid[row][collum] != @piece && @board.grid[row][collum] != ''
                temp['taken'] << [row, collum]
            elsif @board.grid[row][collum] == ''
                temp['block'] << [row, collum]
            end
            row += 1; collum -= 1; counter += 1
        end
        check_board(temp['taken'].length, temp['block'])
    end

    def fork_move()
        temp = {'mine' => [], 'blank' => [], 'holdmine' => [], 'options' => []}
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |tile, ii|
                if tile == @piece
                    temp['mine'] << [i, ii]
                elsif tile == ''
                    temp['blank'] << [i, ii]
                end
            end
            if temp['mine'].length == 1 && temp['blank'].length == @end_point
                temp['holdmine'] << temp['mine'][0]
                temp['options'] << temp['blank'][0]; temp['options'] << temp['blank'][1]
                if temp['holdmine'].length == 2
                    if @board.check_place(temp['holdmine'][0][0], temp['holdmine'][1][0])
                        return place_piece(temp['holdmine'][0][0], temp['holdmine'][1][0])
                    elsif @board.check_place(temp['holdmine'][0][1], temp['holdmine'][1][1])
                        return place_piece(temp['holdmine'][0][1], temp['holdmine'][1][1])
                    end
                end
            end
            temp['mine'] = []; temp['blank'] = []
        end
        false
    end


    def find_vertical_fork()
        collum = 0
        while collum < @board.size
            temp = {'taken' => [], 'grab' => []}
            counter = 0
            while counter < @board.size
                if @board.grid[counter][collum] != @piece && @board.grid[counter][collum] != ''
                    temp['taken'] << [counter, collum]
                elsif @board.grid[counter][collum] == ''
                    temp['grab'] << [counter, collum]
                end
                counter += 1
            end
            if temp['taken'].length == (@end_point - 1) && temp['grab'].length == 2
                return temp['grab']
            end
            temp['taken'] = []; temp['grab'] = []
            collum += 1
        end
        false
    end

    def find_horizontal_fork()
        @board.grid.each_with_index do |row, i|
            temp = {'taken' => [], 'grab' => []}
            row.each_with_index do |tile, ii|
                if tile != @piece && tile != ''
                    temp['taken'] << [i, ii]
                elsif tile == ''
                    temp['grab'] << [i, ii]
                end
            end
            if temp['taken'].length == (@end_point - 1) && temp['grab'].length == 2
                return temp['grab']
            end
            temp['taken'] = []; temp['grab'] = []
        end
        false
    end

    def block_fork()
        temp = {'mine' => [], 'enemies' => [], 'blank' => []}
        predict = {
            'arrowhead1' => [[0,1], [1,0], [0,0]],
            'arrowhead2' => [[1,0], [2,1], [2,0]],
            'arrowhead3' => [[1,2], [2,1], [2,2]],
            'arrowhead4' => [[0,1], [1,2], [0,2]],
            'triangle1' => [[1,1], [2,2], [0,2]],
            'triangle2' => [[1,1], [2,2], [2,0]],
            'triangle3' => [[1,1], [2,0], [0,2]],
            'triangle4' => [[1,1], [0,2], [2,0]],
            'encirclement1' => [[0,0], [2,2], [0,1]],
            'encirclement2' => [[2,0], [0,2], [0,1]],
            'encirclement3' => [[0,0], [2,2], [2,1]],
            'encirclement4' => [[2,0], [0,2], [2,1]]
        }
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
            predict.each_value do |v|
                if temp['enemies'][0] == v[0] && temp['enemies'][1] == v[1] && @board.check_place(v[2][0], v[2][1])
                    return place_piece(v[2][0], v[2][1])
                end
            end
        end
        false
    end

    def advanced_block_fork()
        row = find_horizontal_fork()
        collum = find_vertical_fork()
        if row.is_a?(Array) && collum.is_a?(Array)
            row.each do |v|
                collum.each do |t|
                    if v == t
                        return place_piece(t[0],t[1])
                    end
                end
            end
        end
        false
    end

    def fork_blocking()
        @board.size > 3 ? advanced_block_fork() : block_fork()
    end

    def center_move()
        center = @board.size/2
        if @board.check_place(center, center)
            return place_piece(center, center)
        end
        false
    end

    def place_oppsite_corner(enemy)
        @corners = [[0, 0], [@end_point, 0], [0, @end_point], [@end_point, @end_point]]
        opposite_corners = [[@end_point, @end_point], [0, @end_point], [@end_point, 0], [0, 0]]
        @corners.each_with_index do |v, i|
            if enemy[0] == v && @board.check_place(opposite_corners[i][0], opposite_corners[i][1])
                return place_piece(opposite_corners[i][0], opposite_corners[i][1])
            end
        end
        false
    end

    def opposite_corner()
        enemy = []
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |v, ii|
                if v != @piece && v != ''
                    if i == 0 || i == @end_point && ii == 0 || ii == @end_point
                        enemy << [i, ii]
                    end
                end
            end
        end
        enemy.length > 0 ? place_oppsite_corner(enemy) : false
    end

    def place_empty_corner()
        corners = [[0, 0], [0, @end_point], [@end_point, 0], [@end_point, @end_point]]
        corners.each do |v|
            if @board.check_place(v[0], v[1])
                return place_piece(v[0], v[1])
            end
        end
        false
    end

    def place_empty_side()
        counter = 1
        while counter < @end_point
            sides = [[0, counter], [counter, 0], [counter, @end_point], [@end_point, counter]]
            sides.each do |v|
                if @board.check_place(v[0], v[1])
                    return place_piece(v[0], v[1])
                end
            end
            counter += 1
        end
        false
    end

    def find_enemy()
        enemy = []
        @board.grid.each_with_index do |row, i|
            row.each_with_index do |v, ii|
                if v != @piece && v != ''
                    enemy << [i, ii]
                end
            end
        end
        return enemy
    end

    def find_empty_spot(enemy)
        open_spot = {}
        enemy.each_with_index do |v, i|
            open_spot["enemy#{i}"] = []
            x = (enemy[i][0] - 1); y = (enemy[i][1] - 1)
            9.times do
                if @board.check_place(x, y)
                    open_spot["enemy#{i}"] << [x, y]
                end
                if y < (@board.size - 1) && y >= 0
                    y += 1
                elsif y == (2) && x < (@board.size - 1)
                    y = 0
                    x += 1
                end
            end
        end
        return open_spot
    end

    def surround_enemy(enemy, open_spot)
        enemy.each_with_index do |v, i|
            open_spot["enemy#{i}"].each do |v|
                if @board.check_place(v[0], v[1])
                    return place_piece(v[0], v[1])
                end
            end
        end
        false
    end

    def last_resort()
        enemy = find_enemy()
        open_spot = find_empty_spot(enemy)
        surround_enemy(enemy, open_spot) != false ? surround_enemy(enemy, open_spot) : false
    end

    # def smart_move()
    #     if @board.turn <= 1
    #         return center_move()
    #     end
    #     method_array = [win_move(), block_move()]
    #     method_array.each do |v|
    #         if v != false
    #             return v
    #         end
    #     end
    #     method_array2 = [fork_move(), fork_blocking()]
    #     method_array2.each do |v|
    #         if v != false
    #             return v
    #         end
    #     end
    #     method_array3 = [opposite_corner(), place_empty_corner(), place_empty_side()]
    #     method_array3.each do |v|
    #         if v != false
    #             return v
    #         end
    #     end
    # end

    def smart_move()
        unless win_move()
            unless block_move()
                unless fork_move()
                    unless fork_blocking()
                        unless center_move()
                            unless opposite_corner()
                                unless place_empty_corner()
                                    unless place_empty_side()
                                        unless last_resort()
                                        end
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