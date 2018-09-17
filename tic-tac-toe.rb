class Game_board

    def initialize(size)
        @size = size
        @grid = Array.new(@size) {Array.new(@size, '')}
        @winner = ''
    end

    def place(piece, x, y)
        if @grid[x][y].length < 1
            @grid[x][y] = piece
        end
    end

    def winner_is?()
        @grid.each do |row|
            if row.all? {|v| v == row[0] }
                @winner = row[0]
                return @winner
            end
        end
    end


    attr_reader :winner
    attr_reader :grid
end