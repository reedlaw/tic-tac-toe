class Board
  attr_accessor :state
  X = 0
  O = 1
  W = 3
  H = 3

  def initialize
    @state = Array.new(W * H)
  end

  def set_cell(x, y, xo)
    state[x + y * W] = xo
  end
end
