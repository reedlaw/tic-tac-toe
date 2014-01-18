require 'sinatra'
require 'sinatra/json'
require 'byebug'
require './lib/constants'
require './lib/entities/board'
require './lib/entities/node'
require './lib/entities/game_tree'
require './lib/interactors/place_mark'

game_tree = GameTree.new
game_tree.build
game_tree.minimax

get '/' do
  redirect '/index.html'
end

post '/choice' do
  puts params
  json ChooseSide.new(params, game_tree).call
end

post '/move' do
  puts params
  json PlaceMark.new(params, game_tree).call
end
