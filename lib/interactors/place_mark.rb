class PlaceMark
  attr_reader :request, :response

  def initialize(request = {}, game_tree)
    @moves = request[:moves].to_a.map { |m| m.last.map(&:to_i) }
    @game_tree = game_tree
  end

  def call
    node = @game_tree.find_child_node(@moves)
    @response = { board: node.best_child.board.state }
  end
end
