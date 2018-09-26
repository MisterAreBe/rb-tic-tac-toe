require 'sinatra'
require_relative 'ttt_require_me.rb'

enable :sessions

temp = Game_board.new(3)
size = temp.size

get '/' do
  erb :index, :layout => :layout 
end

post '/play' do

  redirect '/board'
end

get '/board' do # Where the game is played
  board = session[:board] || Array.new(size) {Array.new(size, '')}
  playerx = session[:playerx] || ''
  playero = session[:playero] || ''
  winner = session[:winner] || ''
  if board.is_a?(Array)
    session[:turn] = 0
  else
    session[:turn] = board.turn
  end

  erb :board, :layout => :layout, locals: {board: board, winner: winner}
end

post '/move' do # Proccessing moves
  puts "I like to move it move it!"
  turn = session[:turn]
  tile = params[:tile]

  if turn.even?
    if session[:xhelp]
      if session[:board].check_place(tile[0], tile[1])
        session[:playerx].place_piece(tile[0], tile[1])
      end
    else
      session[:playerx].move()
    end
  else
    if session[:ohelp]
      if session[:board].check_place(tile[0], tile[1])
        session[:playero].place_piece(tile[0], tile[1])
      end
    else
      session[:playero].move()
    end
  end
  
  unless session[:board].winner_is?()
    session[:winner] = session[:board].winner_is?()
  end
  redirect '/board'
end

post '/set_up' do # Set up the board to start a game
  puts "I got set up oh yea!"
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
  redirect '/board'
end

post '/start_over' do # Set the board and player choices back to blank
  puts "We starting over now!"
  sesstion[:board] = Game_board.new(3)
  sessio[:playerx] = ''
  session[:playero] = ''
  redirect '/board'
end

post '/reset' do # Reset the board but keep the players
  puts "Got reset Bro!"
  session[:board] = board.reset()
  redirect '/board'
end