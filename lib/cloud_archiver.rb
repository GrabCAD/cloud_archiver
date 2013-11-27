require 'cloud_archiver/version'
require 'cloud_archiver/archiver'
require 'cloud_archiver/storage'
require 'cloud_archiver/uploader'
require 'cloud_archiver/archive_file'

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
      archive_file = CloudArchiver::ArchiveFile.new
      stream = Tempfile.new(key)

      zipped_files = CloudArchiver::Archiver.pack(storage, stream.path, files)
      zipped_files.each { |zipped_file| archive_file.add_file(zipped_file) }

      uploaded_file = CloudArchiver::Uploader.upload(storage, File.open(stream), upload_path, name)
      archive_file.uploaded_file = uploaded_file
    ensure
      stream.close
      stream.unlink
    end

    return archive_file
  end
end