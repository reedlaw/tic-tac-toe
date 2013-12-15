class Strategy
  attr_accessor :board

  def move
    row = get_row
    target = get_target_cell(row)
    board.state[target] = X
  end

  def get_row
    board.find_two_in_a_row.first
  end

  def get_target_cell(row)
    row.get_cells.select { |i| board.state[i].nil? }.first
  end
end
