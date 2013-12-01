class Row
  attr_accessor :type, :index

  def initialize(attributes = {})
    @type = attributes[:type] 
    @index = attributes[:index]
  end

  def get_cells
    case @type
    when HORIZONTAL
      (WIDTH * @index..WIDTH * (@index + 1) - 1).to_a
    when VERTICAL
      Array.new(HEIGHT) { |e| @index + e * HEIGHT }
    when DIAGONAL_FORWARD
      Array.new(HEIGHT) { |e| (@index + e * HEIGHT) + e }
    when DIAGONAL_BACK
      Array.new(HEIGHT) { |e| (@index + e * HEIGHT) + (WIDTH - e - 1) }
    end
  end
end
