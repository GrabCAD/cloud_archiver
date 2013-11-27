class CloudArchiver
  class ArchiveFile
    attr_accessor :files, :uploaded_file

    def initialize
      @files = []
    end

    def add_file(file)
      files << file
    end
  end
end