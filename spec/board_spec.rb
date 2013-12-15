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
      subject.state = [X, X, nil, nil, nil, nil, nil, O, nil]
      subject.find_two_in_a_row.first.type.should eq(HORIZONTAL)
      subject.find_two_in_a_row.first.index.should eq(0)
    end
    context 'with two rows' do
      it 'returns two rows with two marks each' do
        subject.state = [X, X, nil, nil, nil, nil, O, O, nil]
        subject.find_two_in_a_row[0].type.should eq(HORIZONTAL)
        subject.find_two_in_a_row[0].index.should eq(0)
        subject.find_two_in_a_row[1].type.should eq(HORIZONTAL)
        subject.find_two_in_a_row[1].index.should eq(2)
      end
    end
  end

  context '#find_tree_in_a_row' do
    it 'returns a row with three marks' do
      subject.state = [X, X, X, nil, O, nil, nil, O, nil]
      subject.find_three_in_a_row.first.type.should eq(HORIZONTAL)
      subject.find_three_in_a_row.first.index.should eq(0)
    end
  end

  context '#symmetrical?' do
    context 'boards are the same' do
      it 'returns true if boards are symmetrical' do
        board = Board.new
        board.state = [X, nil, nil, nil, nil, nil, nil, nil, nil]
        subject.state = [X, nil, nil, nil, nil, nil, nil, nil, nil]
        subject.symmetrical?(board).should be_true
      end
    end
    context 'boards are mirror images' do
      it 'returns true if boards are symmetrical' do
        board = Board.new
        board.state = [nil, nil, X, nil, O, nil, nil, nil, nil]
        subject.state = [X, nil, nil, nil, O, nil, nil, nil, nil]
        subject.symmetrical?(board).should be_true
      end
    end
  end

  context '#horizontal_mirror' do
    it 'returns mirrored state' do
      board = Board.new
      board.state = [nil, nil, X, nil, O, nil, nil, nil, nil]
      subject.state = [X, nil, nil, nil, O, nil, nil, nil, nil]
      subject.horizontal_mirror.should eq(board.state)
    end
  end

  context '#vertical_mirror' do
    it 'returns mirrored state' do
      board = Board.new
      board.state = [nil, nil, nil, nil, O, nil, X, nil, nil]
      subject.state = [X, nil, nil, nil, O, nil, nil, nil, nil]
      subject.vertical_mirror.should eq(board.state)
    end
  end
end
