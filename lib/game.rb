# -*- coding: utf-8 -*-
class Game
  attr_accessor :players, :board, :nodes, :minimax_score

  def initialize(board = Board.new)
    @board = board
    @players = []
    @nodes = []
  end

  def depth
    @board.state.compact.count
  end

  def current_player
    depth % 2
  end

  def next_player
    (depth + 1) % 2
  end

  def draw?
    board.state.none?(&:nil?) && !winner?
  end

  def winner?
    board.find_three_in_a_row.count > 0
  end

  def winner
    if winner?
      index = board.find_three_in_a_row.first.get_cells.first
      board.state[index]
    end
  end

  def add_node(node)
    unless symmetrical_node_exists?(node)
      nodes << node
    end
  end

  def symmetrical_node_exists?(node)
    nodes.any? { |n| n.board.symmetrical?(node.board) }
  end

  def score(player)
    return 0 if draw?
    return 1 if winner == player
    -1
  end

  def count_nodes
    recursive_count(self)
  end

  def recursive_count(node)
    if node.winner? || node.draw?
      sum = 1
    else
      sum = 0
    end
    node.nodes.each do |n|
      sum += recursive_count(n)
    end
    sum
  end

  class << self
    def minimax(game, maximizing_player = X, player = X, depth = 0)
      if depth > 10 || game.draw? || game.winner?
        alpha = game.score(player)
      else
        other_player = player == X ? O : X
        if maximizing_player == player
          alpha = -1
        else
          alpha = 1
        end
        game.nodes.each do |node|
          subalpha = minimax(node, other_player, player, depth + 1)
          if maximizing_player == player
            if depth == 0 && alpha <= subalpha
              @best_node = node
            end
            alpha = [alpha, subalpha].max
          else
            alpha = [alpha, subalpha].min
          end
        end
      end
      alpha
    end

    def best_node
      @best_node
    end

    def traverse_nodes(node)
      # puts "#{node.nodes.count} #{node.board.state.join(', ')}"
      node.board.state.each_with_index do |mark, i|
        if mark.nil?
          next_board = deep_clone(node.board)
          next_board.state[i] = node.current_player
          child = Game.new(next_board)
          node.nodes << child unless node.symmetrical_node_exists?(child)
          traverse_nodes(child) unless child.winner? || child.draw?
        end
      end
    end

    def deep_clone(board)
      Marshal.load(Marshal.dump(board))
    end
  end
end
