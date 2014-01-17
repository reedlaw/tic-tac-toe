require 'spec_helper'

describe GameTree do
  context '#initialize' do
    it 'has 9 moves' do
    end
  end

  context '#build' do
    it 'creates all possible boards' do
      subject.build
      subject.minimax
      subject.root.children.map(&:score).should eq([0, 0, 0])
      subject.root.children[1].children.map(&:score).should eq([0, 1, 0, 1, 0])
      subject.root.children.map { |c| c.children.count }.reduce(:+).should eq(12)
    end
  end

  context '#find_child_node' do
    it 'returns the child node with matching board' do
      subject.build
      subject.minimax
      moves = [[E, E, E,
                E, X, E,
                E, E, E],
               [E, E, E,
                E, X, E,
                E, E, O]]
      board = Board.new
      board.state = moves.last
      subject.find_child_node(moves).board.should eq(board)
    end
  end
end
