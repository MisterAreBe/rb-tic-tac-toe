class Game_board

    def initialize(size)
        @size = size
        @grid = Array.new(@size) {Array.new(@size, '')}
        @winner = 'No Winner Yet!'
    end

    def place(piece, x, y)
        if @grid[x][y].length < 1
            @grid[x][y] = piece
        end
    end

    def winner_is?()
        # check if winner is horizontal
        @grid.each do |row|
            if row.all? {|v| v == row[0] } && row[0].length > 0
                return row[0]
            end
        end

        # check if winner is vertical
        collum = 0
        while collum < @size
            winner = @grid[collum][0] 
            # winner is the value of grid[0][0] aka top left, increases to next collum
            counter = 0
            @grid.each do |v|
                # if all of the values are the same in a single collum, counter ticks up to size
                unless v[collum] == winner
                    break
                end
                counter += 1
            end
            # if the counter ticked enough, and the winner is not blank, you win
            if counter == @size && winner != ''
                return winner
            end
            # else if starts looking at the next collum
            collum += 1
        end

    end


    attr_reader :grid
end