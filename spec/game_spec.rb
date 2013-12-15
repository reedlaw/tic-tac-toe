require 'spec_helper'
describe Game do
  context 'AI' do
    before(:each) do
      subject.players << Strategy.new
      subject.players << Strategy.new
    end
    context '#current_player' do
      it 'returns the current player' do
        subject.current_player.should be(X)
      end
    end
    context '#next_player' do
      it 'returns the next player' do
        subject.next_player.should be(O)
      end
    end
    context '#draw?' do
      it 'returns true if draw' do
        subject.board.state = [X, X, O, O, O, X, X, O, X]
        subject.draw?.should be_true
      end
      it 'returns false if no draw' do
        subject.board.state = [X, X, nil, nil, O, nil, nil, O, nil]
        subject.draw?.should be_false
      end
    end
    context '#winner?' do
      it 'returns true if winner' do
        subject.board.state = [X, X, X, nil, O, nil, nil, O, nil]
        subject.winner?.should be_true
      end
      it 'returns false if no winner' do
        subject.board.state = [X, X, nil, nil, O, nil, nil, O, nil]
        subject.winner?.should be_false
      end
    end
    context '#winner' do
      it 'returns winning player' do
        subject.board.state = [X, X, X, nil, O, nil, nil, O, nil]
        subject.winner.should eq(X)
      end
    end
    context '#available_moves' do
      it 'returns array of available moves' do
      end
    end
    context '#minimax' do
      # WARNING: slow test
      # it 'chooses the next best move for X' do
      #   subject.board.state = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      #   Game.traverse_nodes(subject)
      #   subject.count_nodes.should eq(1232)
      #   Game.minimax(subject)
      #   Game.best_node.board.state.should eq([nil, nil, nil, nil, nil, nil, nil, X, nil])
      # end
      it 'chooses the next best move for X' do
        subject.board.state = [X, O, O, nil, X, nil, nil, X, O]
        Game.traverse_nodes(subject)
        Game.minimax(subject)
        Game.best_node.board.state.should eq([X, O, O, nil, X, X, nil, X, O])
      end
      it 'chooses the next best move for O' do
        subject.board.state = [X, O, O, nil, X, X, nil, X, O]
        Game.traverse_nodes(subject)
        Game.minimax(subject, O, O)
        Game.best_node.board.state.should eq([X, O, O, O, X, X, nil, X, O])
      end
    end
  end
end
