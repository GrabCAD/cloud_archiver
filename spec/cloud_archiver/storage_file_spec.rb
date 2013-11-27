require 'spec_helper'

class CloudArchiver
  describe StorageFile do
    let(:storage) { double(CloudArchiver::Storage) }

    subject { StorageFile.new('files/1/original.stl') }

    it 'should loop all chuncks' do
      storage.stub(:get).and_yield('a', 0, 1)

      chunks = []
      subject.each_chunk(storage) { |chunk| chunks << chunk }
      chunks.should_not be_empty
    end
  end
end