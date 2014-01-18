class PlaceMark
  attr_reader :request, :response

  def initialize(request = {}, game_tree)
    @boards = get_boards(request[:boards])
    @game_tree = game_tree
  end

  def call
    node = @game_tree.find_best_move(@boards)
    @response = { board: node.board.to_json }
  end

  def get_boards(hash)
    hash.values.map do |board|
      board.map do |cell|
        case cell
          when ''
          E
          when 'X'
          X
          when 'O'
          O
        end
      end
    end
  end
end
