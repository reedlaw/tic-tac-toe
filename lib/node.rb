class Node
  attr_accessor :children, :board, :score

  def <=> other
    score <=> other.score
  end

  def initialize(board)
    @board = board
    @children = []
  end

  def get_score(player)
    return 0 if board.draw?
    return 1 if board.winner == player
    -1
  end

  def depth
    board.state.reject(&:zero?).count
  end

  def current_player
    depth % 2 + 1
  end
end
