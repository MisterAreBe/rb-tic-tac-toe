class Game_board

    def initialize()
        @grid = [[], [], []]
    end

    def place(piece, x, y)
        @grid[x].insert(y, piece)
    end
    
    attr_reader :grid
end