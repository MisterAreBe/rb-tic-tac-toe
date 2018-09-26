require_relative 'ttt_require_me.rb'

def intro() # Intro has the user pick between PvC, CvC, and the piece they want to use
    system('cls')
    puts "Welcome to MisterAreBe's TIC-TAC-TOE!(console edition)"
    sleep(1)
    player = ''
    while true
        puts "Okay, now 'player1' is 'x',"
        puts "And 'player2' is 'o', alright?"
        puts "Now what I need from you is simple."
        puts "Do you want to be 'player1', 'player2', or watch 'ai battle', choose wisely."
        puts "Please keep in mind, 'x'(AKA 'player1') always goes first."
        puts "Another thing to remember, anytime you want to 'quit', just say the word!"
        print "> "; player = gets.chomp
        system('cls')
        if player == 'player1'
            player = 'x'
            break
        elsif player == 'player2'
            player = 'o'
            break
        elsif player == 'ai battle'
            player = 'bot battle'
            break
        elsif player == 'quit'
            exit(0)
        end
    end
    return player
end

# access to set up is granted from picking 'player1' or 'player2'
def set_up(player, board) # Set up has the user pick what ai they play against or pvp
    while true
        if player == 'x'
            notyou = 'o'
        elsif player == 'o'
            notyou = 'x'
        end
        puts "You chose to be #{player}, good job."
        puts "Would you like to play against a 'easy ai', 'medium ai', 'hard ai', or play 'pvp'?"
        print "> "; enemy = gets.chomp
        case enemy
        when 'easy ai'
            enemy = Random_ai.new(notyou, board)
            break
        when 'medium'
            enemy = Sequential_ai.new(notyou, board)
            break
        when 'hard ai'
            enemy = Unbeatable_ai.new(notyou, board)
            break
        when 'pvp'
            enemy = notyou
            break
        when 'quit'
            exit(0)
        end
    end
    return enemy
end

def player_move(player, board) # Player move shows asks for a tile and places the piece
    while true
        puts "List of moves:\nTop Left(tl)|Top Middle(tm)|Top Right(tr)\nCenter Left(cl)|Center Middle(cm)|Center Right(cr)\nBottom Left(bl)|Bottom Middle(bm)|Bottom Right(br)"
        print "> "; move = gets.chomp
        case move
        when 'tl'
            if board.check_place(0, 0)
                board.place(player, 0, 0)
                break
            end
        when 'tm'
            if board.check_place(0, 1)
                board.place(player, 0, 1)
                break
            end
        when 'tr'
            if board.check_place(0, 2)
                board.place(player, 0, 2)
                break
            end
        when 'cl'
            if board.check_place(1, 0)
                board.place(player, 1, 0)
                break
            end
        when 'cm'
            if board.check_place(1, 1)
                board.place(player, 1, 1)
            break
            end
        when 'cr'
            if board.check_place(1, 2)
                board.place(player, 1, 2)
                break
            end
        when 'bl'
            if board.check_place(2, 0)
                board.place(player, 2, 0)
                break
            end
        when 'bm'
            if board.check_place(2, 1)
                board.place(player, 2, 1)
                break
            end
        when 'br'
            if board.check_place(2, 2)
                board.place(player, 2, 2)
                break
            end
        when 'quit'
            exit(0)
        end
    end
end

def show_board(board) # Show the board
    puts "-------------------------------"
    board.grid.each do |v|
        puts "|'#{v[0]}'|'#{v[1]}'|'#{v[2]}'|"
    end
    puts "-------------------------------"
    sleep(1)
end

# Used for player vs computer
def player_vs_computer(player, enemy, board)
    if player == 'x'
        while true
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(player, board)
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            enemy.move()
        end
    elsif player == 'o'
        while true
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            enemy.move()
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(player, board)
        end
    end
    return board.winner_is?()
end

def bot_battle(board) # For bot to battle! CvC
    temp = ['x', 'o']; temp.shuffle!
    bot1_piece = temp.pop; bot2_piece = temp.pop
    puts "You have chosen to watch two bots fight it out!"
    while true
        puts "Please select the difficulty the first bot."
        puts "Options are, 'easy', 'medium', or 'hard'."
        print "> "; bot1 = gets.chomp
        case bot1
        when 'easy'
            bot1 = Random_ai.new(bot1_piece, board)
            break
        when 'medium'
            bot1 = Sequential_ai.new(bot1_piece, board)
            break
        when 'hard'
            bot1 = Unbeatable_ai.new(bot1_piece, board)
            break
        when 'quit'
            exit(0)
        end
    end
    while true
        puts "Please select the difficulty the second bot."
        puts "Options are, 'easy', 'medium', or 'hard'."
        print "> "; bot2 = gets.chomp
        case bot2
        when 'easy'
            bot2 = Random_ai.new(bot2_piece, board)
            break
        when 'medium'
            bot2 = Sequential_ai.new(bot2_piece, board)
            break
        when 'hard'
            bot2 = Unbeatable_ai.new(bot2_piece, board)
            break
        when 'quit'
            exit(0)
        end
    end
    if bot1_piece == 'x'
        while true
            system('cls')
            puts "Alright Bot1 is #{bot1_piece}, and Bot2 is #{bot2_piece}!"
            show_board(board)
            if board.winner_is?() != false
                break
            end
            bot1.move()
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            bot2.move()
        end
    elsif bot2_piece == 'x'
        while true
            system('cls')
            puts "Alright Bot1 is #{bot1_piece}, and Bot2 is #{bot2_piece}!"
            show_board(board)
            if board.winner_is?() != false
                break
            end
            bot2.move()
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            bot1.move()
        end
    end
    return board.winner_is?()
end

def pvp(player, enemy, board) # Player vs player
    if player == 'x'
        while true
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(player, board)
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(enemy, board)
        end
    elsif enemy == 'x'
        while true
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(enemy, board)
            system('cls')
            show_board(board)
            if board.winner_is?() != false
                break
            end
            player_move(player, board)
        end
    end
    return board.winner_is?()
end

while true # Game start
    board = Game_board.new(3)
    player = intro()
    if player == "bot battle"
       winner = bot_battle(board)
    else
        enemy = set_up(player, board)
        if enemy.is_a?(String)
            winner = pvp(player, enemy, board)
        else
            winner = player_vs_computer(player, enemy, board)
        end
    end
    puts "The winner is #{winner}!"
    sleep(1)
    while true
        puts "Would you like start over 'y', or 'quit'?"
        print "> "; option = gets.chomp
        if option == "y"
            break
        elsif option == "quit"
            exit(0)
        end
    end
end