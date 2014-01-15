require 'sinatra'
require './lib/constants'
require './lib/board'
require './lib/node'
require './lib/game_tree'

game_tree = GameTree.new
game_tree.build
game_tree.minimax

get '/' do
  redirect '/index.html'
end

post '/choice' do
  puts "choose " + params[:side]
  best_node = game_tree.root.children.sort.last
  puts "X moves:"
  best_node.board.render
end
