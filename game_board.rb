class Game_board

    def initialize(size)
        @size = size
        @grid = Array.new(@size) {Array.new(@size, '')}
        @turn = 0
    end

    def check_place(x, y)
        if @grid[x][y] == ''
            return true
        else
            return false
        end
    end

    def place(piece, x, y)
        @grid[x][y] = piece
        @turn += 1
    end

    def winner_is?()
        # check if winner is horizontal
        @grid.each do |row|
            if row.all? {|v| v == row[0] } && row[0].length > 0
                return row[0]
            end
        end

        # check if winner is vertical
        row = 0
        while row < @size
            collum = 0
            while collum < @size
                winner = @grid[collum][row] 
                # winner is the value of grid[0][0] aka top left, increases to next collum
                counter = 0
                while counter < @size
                    unless @grid[counter][collum] == winner
                        break
                    end
                    counter += 1
                end
                # if the counter ticked enough, and the winner is not blank, you win
                if counter == @size && winner != ''
                    return winner
                end
                # else starts looking at the next collum
                collum += 1
            end
            row += 1
        end

        # check if winner is diagonal down
        winner = @grid[0][0]
        collum = 0
        row = 0
        counter = 0
        while counter < @size
            unless @grid[collum][row] == winner
                break
            end
            collum += 1
            row += 1
            counter += 1
        end
        if collum == @size && winner != ''
            return winner
        end

        # check if winner is diagonal upwards
        winner = @grid[0][2]
        collum = 0
        row = 2
        counter = 0
        while counter < @size
            unless @grid[collum][row] == winner
                break
            end
            collum += 1
            row -= 1
            counter += 1
        end
        if collum == @size && winner != ''
            return winner
        end

        # check if out of turns
        if @turn == (@size * @size)
            return "Draw"
        end

        false
    end

    def reset()
        @grid = Array.new(@size) {Array.new(@size, '')}
        @turn = 0
    end

    

    attr_reader :turn
    attr_reader :size
    attr_reader :grid
end