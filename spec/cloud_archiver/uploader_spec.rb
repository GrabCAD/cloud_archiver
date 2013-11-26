require 'spec_helper'

class CloudArchiver
  describe Uploader do
    let(:storage) { double(CloudArchiver::Storage) }
    let(:stream) { double(Tempfile) }
    let(:upload_path) { 'uploads/file' }
    let(:name) { 'file_name' }
    let(:file) { double }

    subject { Uploader }

    describe 'when uploading a file' do
      it 'upload that file' do
        storage.stub(:create).and_return(file)
        subject.upload(storage, stream, upload_path, name)
      end
    end
  end
end