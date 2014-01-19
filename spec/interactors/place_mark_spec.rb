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
      subject.response.should eq({ board: ['O', '', '', '', 'X', '', '', '', ''] })
    end

    it 'returns the AI move' do
      subject = PlaceMark.new({ boards: {
                                  '0' => ['', '', '',
                                          '', '', '',
                                          '', '', ''],
                                  '1' => ['', '', '',
                                          '', 'X', '',
                                          '', '', ''],
                                  '2' => ['O', '', '',
                                          '', 'X', '',
                                          '', '', ''] }
                              },
                              GAME_TREE)
      subject.call
      subject.response.should eq({ board: ['O', '', '',
                                           '', 'X', '',
                                           '', '', 'X'] })
    end

    it 'returns the AI move' do
      subject = PlaceMark.new({ boards: {
                                  '0' => ['', '', '',
                                          '', '', '',
                                          '', '', ''],
                                  '1' => ['', '', '',
                                          '', 'X', '',
                                          '', '', ''],
                                  '2' => ['O', '', '',
                                          '', 'X', '',
                                          '', '', ''],
                                  '3' => ['O', '', 'X',
                                          '', 'X', '',
                                          '', '', ''] }
                              },
                              GAME_TREE)
      subject.call
      subject.response.should eq({ board: ['O', '', 'X',
                                           '', 'X', '',
                                           'O', '', ''] })
    end

    it 'returns the AI move' do
      subject = PlaceMark.new({ boards: {
                                  '0' => ['', '', '',
                                          '', '', '',
                                          '', '', ''],
                                  '1' => ['', '', '',
                                          '', 'X', '',
                                          '', '', ''],
                                  '2' => ['O', '', '',
                                          '', 'X', '',
                                          '', '', ''],
                                  '3' => ['O', '', 'X',
                                          '', 'X', '',
                                          '', '', ''],
                                  '4' => ['O', '', 'X',
                                          '', 'X', '',
                                          'O', '', ''] }
                              },
                              GAME_TREE)
      subject.call
      subject.response.should eq({ board: ['O', '', 'X',
                                           'X', 'X', '',
                                           'O', '', ''] })
    end

    context 'AI winner' do
      it 'returns the AI move and the winner' do
        subject = PlaceMark.new({ boards: {
                                    '0' => ['', '', '',
                                            '', '', '',
                                            '', '', ''],
                                    '1' => ['', '', '',
                                            '', 'X', '',
                                            '', '', ''],
                                    '2' => ['O', '', '',
                                            '', 'X', '',
                                            '', '', ''],
                                    '3' => ['O', '', 'X',
                                            '', 'X', '',
                                            '', '', ''],
                                    '4' => ['O', '', 'X',
                                            '', 'X', '',
                                            'O', '', ''],
                                    '5' => ['O', '', 'X',
                                            '', 'X', '',
                                            'O', '', 'X'] }
                                },
                                GAME_TREE)
        subject.call
        subject.response.should eq({ board: ['O', '', 'X',
                                             'O', 'X', '',
                                             'O', '', 'X'],
                                     winner: 'O' })
      end
    end

    context 'draw' do
      it 'returns the AI move and the draw flag' do
        subject = PlaceMark.new({ boards: {
                                    '0' => ['', '', '',
                                            '', '', '',
                                            '', '', ''],
                                    '1' => ['', '', '',
                                            '', 'X', '',
                                            '', '', ''],
                                    '2' => ['O', '', '',
                                            '', 'X', '',
                                            '', '', ''],
                                    '3' => ['O', '', 'X',
                                            '', 'X', '',
                                            '', '', ''],
                                    '4' => ['O', '', 'X',
                                            '', 'X', '',
                                            'O', '', ''],
                                    '5' => ['O', '', 'X',
                                            'X', 'X', '',
                                            'O', '', ''],
                                    '6' => ['O', '', 'X',
                                            'X', 'X', 'O',
                                            'O', '', ''],
                                    '7' => ['O', '', 'X',
                                            'X', 'X', 'O',
                                            'O', 'X', ''],
                                    '8' => ['O', 'O', 'X',
                                            'X', 'X', 'O',
                                            'O', 'X', ''] }
                                },
                                GAME_TREE)
        subject.call
        subject.response.should eq({ board: ['O', 'O', 'X',
                                             'X', 'X', 'O',
                                             'O', 'X', 'X'],
                                     draw: true })
      end
    end
  end
end
