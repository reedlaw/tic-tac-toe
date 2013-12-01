require 'spec_helper'

describe Board do
  context '#initialize' do
    it 'creates an empty board' do
      subject.state.should_not include(X, O)
    end

    it 'creates rows' do
      subject.rows.count.should eq(8)
    end
  end

  context '#set_cells' do
    it 'sets a board cell at coords {x, y} to either X or O' do
      subject.set_cell(0, 0, X)
      subject.state.should eq([X, *Array.new(W * H - 1)])
    end
  end

  context '#find_two_in_a_row' do
    it 'returns a row with two marks' do
      subject.state = [X, X, nil, nil, O, nil, nil, O, nil]
      subject.find_two_in_a_row(X).first.type.should eq(HORIZONTAL)
      subject.find_two_in_a_row(X).first.index.should eq(0)
    end
  end
end
