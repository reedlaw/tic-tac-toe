class ChooseSide
  attr_reader :request, :response

  def initialize(request = {}, game_tree)
    @choice = request[:side]
    @game_tree = game_tree
  end

  def call
    if @choice == 'X'
      @response = { human_player_move: true }
    else
      node = @game_tree.root.best_child
      @response = { board: node.board.state }
    end
  end
end
