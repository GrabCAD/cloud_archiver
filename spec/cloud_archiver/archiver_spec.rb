require 'spec_helper'

class CloudArchiver
  describe Archiver do
    let(:stream) { double(Tempfile) }
    let(:files) { [{ name: 'test.jpg', remote_path: 'images/1/original.jpg' }] }
    let(:archive) { double(Zip::OutputStream) }
    let(:storage) { double(CloudArchiver::Storage) }

    subject { Archiver }

    it 'should pack files to archive' do
      stream.stub(:path).and_return('')
      Zip::OutputStream.stub(:new).and_return(archive)
      archive.should_receive(:put_next_entry).once
      archive.should_receive(:close)
      StorageFile.any_instance.should_receive(:each_chunk).once
      subject.pack(storage, stream.path, files)
    end
  end
end