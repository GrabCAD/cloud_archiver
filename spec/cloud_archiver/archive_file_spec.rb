require 'spec_helper'

class CloudArchiver
  describe ArchiveFile do
    let(:file) { double }

    subject { ArchiveFile.new }

    describe 'when adding a new file to archive file' do
      it 'adds a file' do
        subject.add_file(file)
        subject.files.should == [file]
      end
    end
  end
end