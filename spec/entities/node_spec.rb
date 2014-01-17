require 'spec_helper'

describe Node do
  let(:best_board) { b = Board.new; b.state = [E, E, E,
                                               E, X, E,
                                               E, E, E]; b}
  let(:second_best) { b = Board.new; b.state = [E, E, E,
                                                X, E, E,
                                                E, E, E]; b}
  let(:subject) { Node.new(Board.new) }
  context '#best_child' do
    it 'returns the child node with the best score for the current player' do
      node1 = Node.new(best_board)
      node1.score = 1
      node2 = Node.new(second_best)
      node2.score = 0
      subject.children = [node1, node2]
      subject.best_child.should equal(node1)
    end
  end
end
