require 'constants'
require 'entities/board'
require 'entities/node'
require 'entities/game_tree'
require 'interactors/place_mark'

GAME_TREE = GameTree.new
GAME_TREE.build
GAME_TREE.minimax
