class Game_board

    def initialize()
        @grid = [[], [], []]
        @grid.each do |v|
            3.times do 
                v << ''
            end
        end
    end

    def place(piece, x, y)
        if @grid[x][y].length < 1
            @grid[x][y] = piece
        end
    end

    attr_reader :grid
end