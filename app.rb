require 'sinatra'
require_relative 'ttt_require_me.rb'

enable :sessions

get '/' do
  erb :index, :layout => :layout 
end

post '/play' do

  redirect '/board'
end

get '/board' do

  erb :board, :layout => :layout, local: {}
end

post '/move' do

  redirect '/board'
end