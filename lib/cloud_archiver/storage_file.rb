class CloudArchiver
  #
  # Get the chunk of the file.
  #
  class StorageFile
    attr_accessor :path, :storage

    def initialize(storage, path)
      @path = path
      @storage = storage
    end

    def each_chunk
      storage.get(path) do |chunk, remaining, total|
        yield chunk
      end
    end
  end
end