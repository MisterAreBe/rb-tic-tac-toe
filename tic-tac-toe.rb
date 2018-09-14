class Game_board

    def initialize()
        @grid = [[], [], []]
        @grid.each do |v|
            3.times do 
                v << ' '
            end
        end
    end

    def place(piece, x, y)
        @grid[x][y] = piece
    end

    attr_reader :grid
end