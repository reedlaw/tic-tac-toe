class Board
  attr_accessor :state, :rows

  def initialize
    @state = Array.new(WIDTH * HEIGHT)
    @rows = []
    [HORIZONTAL, VERTICAL].each do |dir|
      dim = dir == HORIZONTAL ? WIDTH : HEIGHT
      1.upto(dim) { |i| @rows << Row.new(type: dir, index: i - 1) }
    end
    @rows << Row.new(type: DIAGONAL_FORWARD, index: 0)
    @rows << Row.new(type: DIAGONAL_BACK, index: 0)
  end

  def set_cell(x, y, xo)
    state[x + y * W] = xo
  end

  def find_two_in_a_row(xo)
    rows.select { |r| state.values_at(*r.get_cells).compact == [xo, xo] } 
  end
end
