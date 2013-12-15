class Board
  attr_accessor :state, :rows

  def initialize
    @state = Array.new(WIDTH * HEIGHT)
    @rows = initialize_rows
  end

  def initialize_rows
    (0..3).each_with_object([]) do |direction, rows|
      if direction == HORIZONTAL || direction == VERTICAL
        0.upto(2) { |i| rows << Row.new(type: direction, index: i) }
      else
        rows << Row.new(type: direction, index: 0)
      end
    end
  end

  def set_cell(x, y, xo)
    state[x + y * W] = xo
  end

  def find_two_in_a_row
    find_in_a_row(2)
  end

  def find_three_in_a_row
    find_in_a_row(3)
  end

  def find_in_a_row(x)
    rows.select do |r|
      marks = state.values_at(*r.get_cells).compact
      marks.count == x && marks.uniq.count == 1
    end
  end

  def symmetrical?(board)
    board.state == state ||
    board.horizontal_mirror == state
  end

  def horizontal_mirror
    (0..2).map do |row_index|
      row = rows.select { |r| r.type == HORIZONTAL && r.index == row_index }.first
      state.values_at(*row.get_cells).reverse
    end.flatten
  end

  def vertical_mirror
    arrays = (0..2).map do |row_index|
      row = rows.select { |r| r.type == VERTICAL && r.index == row_index }.first
      state.values_at(*row.get_cells).reverse
    end
    first_row = arrays.map { |a| a[0] }
    second_row = arrays.map { |a| a[1] }
    third_row = arrays.map { |a| a[2] }
    [first_row, second_row, third_row].flatten
  end
end
