require 'spec_helper'

describe Strategy do
  context 'win' do
    context 'two in a row' do
      before(:each) do
        board = Board.new
        board.state = [X, X, nil, nil, O, nil, nil, O, nil]
        subject { described_class.board = board }
      end
      it 'places a third mark' do
        subject.move
      end
    end
  end
end
