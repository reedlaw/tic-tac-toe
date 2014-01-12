require 'byebug'
require './lib/constants'
require './lib/board'
require './lib/node'
require './lib/game_tree'

game_tree = GameTree.new
game_tree.build
game_tree.minimax
100.times do
  best_node = game_tree.root.children.sort.last
  puts "X moves:"
  best_node.board.render
  puts
  puts "O moves:"
  node = best_node.children.sample
  node.board.render
  while !node.board.winner && !node.board.draw? do
    puts
    puts "X moves:"
    node = node.children.sort.last
    node.board.render
    break if node.children.empty?
    puts
    puts "O moves:"
    node = node.children.sample
    node.board.render
  end
  if node.board.draw?
    puts "It was a tie"
  else
    puts "Winner is " + (node.board.winner == X ? "X" : "O")
  end
  puts "+++++++++++++++++++++++++++"
end
