require 'fog'

class CloudArchiver
  #
  # Storage.
  #
  class Storage
    attr_reader :storage_attributes, :bucket

    def initialize(storage_attributes)
      @bucket = storage_attributes.delete(:bucket)
      @storage_attributes = storage_attributes
    end

    def connection
      @connection ||= Fog::Storage.new(storage_attributes)
    end

    def directory
      @directory ||= connection.directories.get(bucket)
    end

    def get(path, &block)
      directory.files.get(path, &block)
    end

    def create(path, file)
      file_in_storage = directory.files.new(key: path, body: file)
      yield file_in_storage if block_given?
      file_in_storage.save

      return file_in_storage
    end
  end
end