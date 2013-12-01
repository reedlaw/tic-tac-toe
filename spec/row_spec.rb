require 'spec_helper'

describe Row do
  context '#get_cells' do
    context 'horizontal' do
      subject { Row.new(type: HORIZONTAL, index: 0) }
      it 'returns an array of cell indices' do
        subject.get_cells.should eq([0, 1, 2])
      end
    end
    context 'vertical' do
      subject { Row.new(type: VERTICAL, index: 0) }
      it 'returns an array of cell indices' do
        subject.get_cells.should eq([0, 3, 6])
      end
    end
    context 'diagonal forward' do
      subject { Row.new(type: DIAGONAL_FORWARD, index: 0) }
      it 'returns an array of cell indices' do
        subject.get_cells.should eq([0, 4, 8])
      end
    end
    context 'diagonal back' do
      subject { Row.new(type: DIAGONAL_BACK, index: 0) }
      it 'returns an array of cell indices' do
        subject.get_cells.should eq([2, 4, 6])
      end
    end
  end
end
