require 'spec_helper'

describe Board do
  context '#initialize' do
    it 'is empty' do
      subject.state.should eq([E, E, E,
                               E, E, E,
                               E, E, E])
    end
  end

  context '#==' do
    it 'is a permutation (reflection/rotation) of the other board' do
      other_board = Board.new
      other_board.state = [X, O, O,
                           O, X, X,
                           O, X, O]
      subject.state = [O, O, X,
                       X, X, O,
                       O, X, O]
      subject.should eq(other_board)
      other_board.state = [X, E, X,
                           E, E, O,
                           E, E, E]
      subject.state = [E, E, X,
                       E, E, E,
                       E, O, X]
      subject.should eq(other_board)

    end
  end

  context '#set_cells' do
    it 'sets a board cell at coords {x, y} to either X or O' do
      subject.set_cell(0, 0, X)
      subject.state.should eq([X, E, E,
                               E, E, E,
                               E, E, E])
      subject.set_cell(2, 2, O)
      subject.state.should eq([X, E, E,
                               E, E, E,
                               E, E, O])
    end
  end

  context '#winner' do
    it 'returns winning player' do
      subject.state = [X, X, X,
                       O, O, X,
                       X, O, O]
      subject.winner.should eq(X)
      subject.state = [O, X, X,
                       X, O, X,
                       X, O, O]
      subject.winner.should eq(O)
    end
  end

  context '#depermutate' do
    it 'permutates a mirrored/rotated board to match another board' do
      subject.state = [O, E, O,
                       E, X, E,
                       E, E, X]
      board = Board.new
      board.state = [O, E, X,
                     E, X, E,
                     E, E, E]
      subject.depermutate(board)
      subject.depermutate(board).should eq([O, E, X,
                                            E, X, E,
                                            O, E, E])
    end
  end
end
