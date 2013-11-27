require 'cloud_archiver/version'
require 'cloud_archiver/archiver'
require 'cloud_archiver/storage'
require 'cloud_archiver/uploader'

class CloudArchiver
  attr_reader :storage_attributes

  def initialize(storage_attributes)
    @storage_attributes = storage_attributes
  end

  def storage
    @storage ||= Storage.new(storage_attributes)
  end

  def archive(files, key, name, upload_path)
    begin
      archive = Archive.new
      stream = Tempfile.new(key)

      zipped_files = CloudArchiver::Archiver.pack(storage, stream.path, files)
      zipped_files.each { |zipped_file| archive.add_file(zipped_file) }

      uploaded_file = CloudArchiver::Uploader.upload(storage, File.open(stream), upload_path, name)
      archive.uploaded_file = uploaded_file
    ensure
      stream.close
      stream.unlink
    end
    return archive
  end

  class Archive
    attr_accessor :files, :uploaded_file

    def initialize
      @files = []
    end

    def add_file(file)
      files << file
    end
  end
end