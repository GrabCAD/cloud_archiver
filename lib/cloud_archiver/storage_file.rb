class CloudArchiver
  #
  # Get the chunk of the file.
  #
  class StorageFile
    attr_accessor :path

    def initialize(path)
      @path = path
    end

    def each_chunk(storage)
      storage.get(path) do |chunk, remaining, total|
        yield chunk
      end
    end
  end
end