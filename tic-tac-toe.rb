class Game_board

    def initialize(size)
        @size = size
        @grid = Array.new(@size) {Array.new(@size, '')}
    end

    def place(piece, x, y)
        if @grid[x][y].length < 1
            @grid[x][y] = piece
        end
    end

    attr_reader :grid
end