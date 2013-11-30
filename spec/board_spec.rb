require 'board'

describe Board do
  context '#initialize' do
    it 'creates an empty board' do
      subject.state.should_not include(Board::X, Board::O)
    end
  end

  context '#set_cells' do
    it 'sets a board cell at coords {x, y} to either X or O' do
      subject.set_cell(0, 0, Board::X)
      subject.state.should eq([Board::X, *Array.new(Board::W * Board::H - 1)])
    end
  end
end
