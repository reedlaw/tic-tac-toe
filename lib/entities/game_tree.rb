# -*- coding: utf-8 -*-
class GameTree
  attr_accessor :root

  def initialize
    @root = Node.new(Board.new)
  end

  def build(node = @root)
    node.board.state.each_with_index do |cell, i|
      if cell == E
        temp_board = Board.new
        temp_board.state = node.board.state.dup
        temp_board.state[i] = node.current_player
        unless node.children.any? { |n| n.board == temp_board }
          child = Node.new(temp_board)
          child.score = child.get_score(node.current_player)
          node.children << child
          build(child)
        end
      end
    end
  end

  def minimax(node = @root, depth = 0, maximizing_player = X, player = X)
    if node.board.depth > 8  || node.board.draw? || node.board.winner
      return node.score = node.get_score(player)
    end
    other_player = player == X ? O : X
    if maximizing_player == player
      alpha = -1
      node.children.each do |child|
        subalpha = minimax(child, depth + 1, other_player, player)
        alpha = [alpha, subalpha].max
      end
    else
      alpha = 1
      node.children.each do |child|
        subalpha = minimax(child, depth + 1, player, player)
        alpha = [alpha, subalpha].min
      end
    end
    return node.score = alpha
  end

  def find_best_move(boards)
    return @root.best_child.board if boards.count == 1
    boards.shift
    board = Board.new
    node = @root
    while not boards.empty?
      board.state = boards.shift
      node = node.children.select { |child| child.board == board }.first
      break if board.draw?
      node = node.best_child if boards.empty?
    end
    new_board = node.board.dup
    new_board.depermutate(board)
    new_board
  end
end
