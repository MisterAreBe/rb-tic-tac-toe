require 'sinatra'
require_relative 'ttt_require_me.rb'

enable :sessions

get '/' do
  erb :index, :layout => :layout 
end

post '/play' do

  redirect '/board'
end

get '/board' do # Where the game is played
  temp = Game_board.new(3)
  board = session[:board] || temp
  playerx = session[:playerx] || ''
  playero = session[:playero] || ''
  winner = session[:winner] || ''
  if board.is_a?(Array)
    session[:turn] = 0
  else
    session[:turn] = board.turn
  end
  show_board = session[:show_board] || "hide"
  show_players = session[:show_players] || "show"
  show_set_up = session[:show_set_up] || "show"
  show_winner = session[:show_winner] || "hide"
  show_reset = session[:show_reset] || "hide"
  temp_arr = [show_set_up, show_winner, show_reset]
  if temp_arr.any? {|v| v == "show"}
    show_options = "show"
  else
    show_options = "hide"
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

  erb :board, :layout => :layout, locals: {board: board, winner: winner, show_board: show_board, show_players: show_players, show_set_up: show_set_up, show_winner: show_winner, show_reset: show_reset, show_options: show_options, bot_bot: bot_bot}
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
      session[:playero].move()
    end
  elsif session[:ohelp] && !session[:xhelp] && !turn.even?
    if session[:board].check_place(tile[0], tile[1])
      session[:playero].place_piece(tile[0], tile[1])
      session[:playerx].move()
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
    session[:playero].move()
    if session[:comp_vs_comp] == "bot battle" && turn > 0
      sleep(1)
    end
  end
   # For Computer vs Computer --end
  
  session[:show_board] = "show"
  session[:show_players] = "hide"
  session[:show_set_up] = "hide"
  session[:show_winner] = "hide"
  session[:show_reset] = "hide"

  if session[:board].winner_is?() != false
    session[:winner] = "#{session[:board].winner_is?()}"
    session[:show_winner] = "show"
    session[:show_reset] = "show"
    session[:comp_vs_comp] = "not_bot"
  end

  redirect '/board'
end

post '/set_up' do # Set up the board to start a game
  session[:board] = Game_board.new(3)
  x = params[:playerx]
  o = params[:playero]
  session[:xhelp] = false
  session[:ohelp] = false
  case x
  when 'easy'
    session[:playerx] = Random_ai.new('x', session[:board])
  when 'medium'
    session[:playerx] = Sequential_ai.new('x', session[:board])
  when 'hard'
    session[:playerx] = Unbeatable_ai.new('x', session[:board])
  when 'human'
    session[:playerx] = Base_ai.new('x', session[:board])
    session[:xhelp] = true
  end
  case o
  when 'easy'
    session[:playero] = Random_ai.new('o', session[:board])
  when 'medium'
    session[:playero] = Sequential_ai.new('o', session[:board])
  when 'hard'
    session[:playero] = Unbeatable_ai.new('o', session[:board])
  when 'human'
    session[:playero] = Base_ai.new('o', session[:board])
    session[:ohelp] = true
  end

  if session[:ohelp] && !session[:xhelp]
    session[:playerx].move()
  elsif !session[:xhelp] && !session[:ohelp]
    session[:comp_vs_comp] = "bot battle"
  end

  session[:show_board] = "show"
  session[:show_players] = "hide"
  session[:show_set_up] = "hide"
  session[:show_winner] = "hide"
  session[:show_reset] = "hide"
  redirect '/board'
end

post '/start_over' do # Set the board and player choices back to blank
  session[:board] = Game_board.new(3)
  session[:playerx] = ''
  session[:playero] = ''
  session[:show_board] = "hide"
  session[:show_players] = "show"
  session[:show_set_up] = "show"
  session[:show_winner] = "hide"
  session[:show_reset] = "hide"
  session[:comp_vs_comp] = "not_bot"
  redirect '/board'
end

post '/reset' do # Reset the board but keep the players
  session[:board].reset()
  session[:show_board] = "show"
  session[:show_players] = "hide"
  session[:show_set_up] = "hide"
  session[:show_winner] = "hide"
  session[:show_reset] = "hide"
  if session[:ohelp] && !session[:xhelp]
    session[:playerx].move()
  elsif !session[:xhelp] && !session[:ohelp]
    session[:comp_vs_comp] = "bot battle"
  end
  redirect '/board'
end