class Node
  attr_accessor :children, :board, :score

  def <=> other
    score <=> other.score
  end

  def initialize(board)
    @board = board
    @children = []
  end

  def best_child
    if board.depth % 2 == 1
      @children.sort.first
    else
      @children.sort.last
    end
  end

  def get_score(player)
    return 0 if board.draw?
    return 1 if board.winner == player
    -1
  end

  def current_player
    board.depth % 2 + 1
  end
end
