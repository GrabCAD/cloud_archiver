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
    stream = Tempfile.new(key)

    pack(storage, stream.path, files)
    upload(storage, stream, upload_path, name)
  ensure
    stream.close
    stream.unlink
  end

  # Zip the file.
  def pack(storage, stream_path, files)
    CloudArchiver::Archiver.pack(storage, stream_path, files)
  end

  # Upload to provider.
  def upload(storage, stream, upload_path, name)
    CloudArchiver::Uploader.upload(storage, File.open(stream), upload_path, name)
  end
end