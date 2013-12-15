require 'spec_helper'

describe Strategy do
  context 'win' do
    context 'two in a row' do
      before(:each) do
        board = Board.new
        board.state = [X, X, nil, nil, O, nil, nil, O, nil]
        subject.board = board
      end
      it 'places a third mark' do
        subject.move
        subject.board.state.should eq([X, X, X, nil, O, nil, nil, O, nil])
      end
    end
  end
end
