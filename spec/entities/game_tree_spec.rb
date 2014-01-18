require 'spec_helper'

describe GameTree do
  context '#initialize' do
    it 'has 9 moves' do
    end
  end

  context '#build' do
    it 'creates all possible boards' do
      GAME_TREE.root.children.map(&:score).should eq([0, 0, 0])
      GAME_TREE.root.children[1].children.map(&:score).should eq([0, 1, 0, 1, 0])
      GAME_TREE.root.children.map { |c| c.children.count }.reduce(:+).should eq(12)
    end
  end

  context '#find_best_move' do
    it 'returns the best child if AI turn' do
      boards = [[E, E, E,
                E, E, E,
                E, E, E]]
      board = Board.new
      board.state = [E, E, E,
                     E, X, E,
                     E, E, E]
      GAME_TREE.find_best_move(boards).board.should eq(board)
    end

    it 'returns the child node with matching board' do
      boards = [[E, E, E,
                E, E, E,
                E, E, E],
               [E, E, E,
                E, X, E,
                E, E, E]]
      board = Board.new
      board.state = [O, E, E,
                     E, X, E,
                     E, E, E]
      GAME_TREE.find_best_move(boards).board.should eq(board)
    end

    it 'returns the child node with matching board' do
      boards = [[E, E, E,
                E, E, E,
                E, E, E],
               [E, E, E,
                E, X, E,
                E, E, E],
               [O, E, E,
                E, X, E,
                E, E, E]]
      board = Board.new
      board.state = [O, E, E,
                     E, X, E,
                     E, E, X]
      GAME_TREE.find_best_move(boards).board.should eq(board)
    end
  end
end
