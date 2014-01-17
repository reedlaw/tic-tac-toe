require 'spec_helper'

describe PlaceMark do
  context '#call' do
    let(:subject) { PlaceMark.new({ board: [E, E, E,
                                            E, X, E,
                                            E, E, E] },
                                  GameTree.new) }
    it 'returns the next board state' do
      subject.call
      subject.response.should eq([O, E, E,
                                  E, X, E,
                                  E, E, E])
    end
  end
end 
