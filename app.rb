require 'sinatra'
require_relative 'ttt_require_me.rb'

enable :sessions

get '/' do
  erb :index, :layout => :layout 
end

post '/play' do # Set up the board to start a game
  session[:size] = params[:size] || 3
  session[:board] = Game_board.new(session[:size].to_i)
  session[:playerx] = params[:playerx] || ''
  session[:playero] = params[:playero] || ''
  session[:xhelp] = false
  session[:ohelp] = false

  case session[:playerx]
  when 'easy'
    session[:playerx] = Random_ai.new('x', session[:board])
  when 'medium'
    session[:playerx] = Sequential_ai.new('x', session[:board])
  when 'hard'
    session[:playerx] = Unbeatable_ai_2.new('x', session[:board])
  when 'human'
    session[:playerx] = Base_ai.new('x', session[:board])
    session[:xhelp] = true
  end

  case session[:playero]
  when 'easy'
    session[:playero] = Random_ai.new('o', session[:board])
  when 'medium'
    session[:playero] = Sequential_ai.new('o', session[:board])
  when 'hard'
    session[:playero] = Unbeatable_ai_2.new('o', session[:board])
  when 'human'
    session[:playero] = Base_ai.new('o', session[:board])
    session[:ohelp] = true
  end

  if session[:ohelp] && !session[:xhelp]
    session[:playerx].move()
  elsif !session[:xhelp] && !session[:ohelp]
    session[:comp_vs_comp] = "bot battle"
  end
  session[:winner] = ''
  redirect '/board'
end

get '/board' do # Where the game is played
  board = session[:board]
  playerx = session[:playerx] || ''
  playero = session[:playero] || ''
  winner = session[:winner] || ''

  if board.is_a?(Array)
    session[:turn] = 0
  else
    session[:turn] = board.turn
  end

  if winner == "x"
    winner = "Vegeta has won!"
  elsif winner == "o"
    winner = "Goku has won!"
  elsif winner == "Draw"
    winner = "Draw!"
  else
    winner = ''
  end

  bot_bot = session[:comp_vs_comp] || "not_bot"

  erb :board, :layout => :layout, locals: {board: board, winner: winner, bot_bot: bot_bot}
end

post '/move' do # Proccessing moves
    turn = session[:turn]
    temp = params[:tile] || ''
  
    temp = temp.split(',')
    tile = []
    temp.each do |v|
      tile << v.to_i
    end
  
    # Player vs Computer --start
    if session[:xhelp] && !session[:ohelp] && turn.even?
      if session[:board].check_place(tile[0], tile[1])
        session[:playerx].place_piece(tile[0], tile[1])
        if session[:board].winner_is?() == false
          session[:playero].move()
        end
      end
    elsif session[:ohelp] && !session[:xhelp] && !turn.even?
      if session[:board].check_place(tile[0], tile[1])
        session[:playero].place_piece(tile[0], tile[1])
        if session[:board].winner_is?() == false
          session[:playerx].move()
        end
      end
      # Player vs Computer --end
      # For PvP turn taking --start
    elsif session[:xhelp] && turn.even?
      if session[:board].check_place(tile[0], tile[1])
        session[:playerx].place_piece(tile[0], tile[1])
      end
    elsif session[:ohelp] && !turn.even? 
      if session[:board].check_place(tile[0], tile[1])
        session[:playero].place_piece(tile[0], tile[1])
      end
      # For PvP turn taking --end
      # For Computer vs Computer --start
    elsif !session[:xhelp] && !session[:ohelp]
      session[:playerx].move()
      if session[:board].winner_is?() == false
        session[:playero].move()
      end
      if session[:comp_vs_comp] == "bot battle" && turn > 0
        sleep(1)
      end
    end
     # For Computer vs Computer --end
    
    if session[:board].winner_is?() != false
      session[:winner] = "#{session[:board].winner_is?()}"
      session[:comp_vs_comp] = "not_bot"
    end
  
    redirect '/board'
  end

  post '/reset' do # Reset the board but keep the players
    session[:board].reset()
    if session[:ohelp] && !session[:xhelp]
      session[:playerx].move()
    elsif !session[:xhelp] && !session[:ohelp]
      session[:comp_vs_comp] = "bot battle"
    end
    session[:winner] = ''
    redirect '/board'
  end

  post '/start_over' do # Set the board and player choices back to blank
    redirect '/'
  end