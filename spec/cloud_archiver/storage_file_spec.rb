require 'spec_helper'

class CloudArchiver
  describe StorageFile do
    let(:storage) { double(CloudArchiver::Storage) }

    subject { StorageFile.new(storage, 'files/1/original.stl') }

    it 'should loop all chuncks' do
      subject.storage = storage
      storage.stub(:get).and_yield('a', 0, 1)

      chunks = []
      subject.each_chunk { |chunk| chunks << chunk }
      chunks.should_not be_empty
    end
  end
end