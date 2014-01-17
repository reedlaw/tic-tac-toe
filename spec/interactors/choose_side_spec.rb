require 'spec_helper'

describe ChooseSide do
  context 'human player chooses X' do
    let(:subject) { ChooseSide.new(choice: 'X') }
    it 'waits for human player to move' do
      subject.call
      subject.response.should eq(human_player_move: true)
    end
  end
  context 'human player chooses O' do
    let(:subject) { ChooseSide.new(choice: 'O') }
    it 'makes a move' do
      subject.call
      subject.response.should eq(human_player_move: false)
    end
  end
end
