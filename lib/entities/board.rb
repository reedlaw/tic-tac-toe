class Board
  attr_accessor :state

  def initialize
    @state = [E, E, E,
              E, E, E,
              E, E, E]
  end

  def == other
    PERMUTATIONS.any? { |perm|
      state == perm.map { |p| other.state[p] }
    }
  end

  def set_cell(x, y, mark)
    position = get_position(x, y)
    @state[position] = mark
  end

  def winner
    [X, O].find do |mark|
      WIN_MASKS.any? do |win|
        mask = bitmask(win, mark)
        compare_masks(win, mask)
      end
    end
  end

  def draw?
    state.none?(&:zero?) && !winner
  end

  def to_json
    board = state.each_with_object([]) do |cell, array|
      array << mark_to_s(cell)
    end
    json = { board: board }
    json[:winner] = mark_to_s(winner) if winner
    json[:draw] = true if draw?
    json
  end

  def depth
    state.reject(&:zero?).count
  end

  def depermutate(other)
    similar_count = 0
    new_state = @state
    PERMUTATIONS.each do |perm|
      perm_state = perm.map { |p| @state[p] }
      matches = perm_state.zip(other.state).map { |a, b| a == b }.count(true)
      if matches > similar_count
        new_state = perm_state
        similar_count = matches
      end
    end
    @state = new_state
  end

  private

  def mark_to_s(cell)
    case cell
    when E
      ''
    when X
      'X'
    when O
      'O'
    end
  end

  def get_position(x, y)
    x + y * 3
  end

  def bitmask(array, mark)
    state.inject(0) do |mask, cell|
      mask * 2 + ((cell==mark) ? 1 : 0)
    end
  end

  def compare_masks(mask1, mask2)
    (mask1 ^ mask2) & mask1 == 0
  end
end
