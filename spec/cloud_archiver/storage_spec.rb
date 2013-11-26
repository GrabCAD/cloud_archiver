require 'spec_helper'

class CloudArchiver
  describe Storage do
    let(:connection) { double(Fog::Storage) }
    let(:bucket) { double(Fog::Collection) }
    let(:files) { double(Fog::Collection) }

    subject { Storage.new({}) }

    before(:each) do
      subject.stub(:connection).and_return(connection)
      subject.stub(:bucket).and_return('bucket')
      connection.stub_chain(:directories, :get).and_return(bucket)
      bucket.stub(:files).and_return(files)
    end

    describe 'when downloading file' do
      it 'should retrive that file' do
        files.stub(:get).and_return('a')
        subject.get('files/1/original.stl').should eq('a')
      end
    end

    describe 'when uploading file' do
      it 'should save file to storage' do
        file = double(Object)
        files.stub(:new).and_return(file)
        file.stub(:multipart_chunk_size=)
        file.should_receive(:save)
        subject.create('files/1/original.stl', 'a')
      end
    end
  end
end