require 'spec_helper'

describe PlaceMark do
  context '#call' do
    it 'returns the AI move' do
      subject = PlaceMark.new({ boards: { '0' => ['', '', '',
                                                  '', '', '',
                                                  '', '', ''] }
                              },
                              GAME_TREE)
      subject.call
      subject.response.should eq({ board: ['', '', '', '', 'X', '', '', '', ''] })
    end

    it 'returns the AI move' do
      subject = PlaceMark.new({ boards: {
                                  '0' => ['', '', '',
                                          '', '', '',
                                          '', '', ''],
                                  '1' => ['', '', '',
                                          '', 'X', '',
                                          '', '', ''] }
                              },
                              GAME_TREE)
      subject.call
      subject.response.should eq({ board: ['', 'O', '', '', 'X', '', '', '', ''] })
    end
  end
end 
