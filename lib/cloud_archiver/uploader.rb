class CloudArchiver
  module Uploader
    MULTIPART_CHUNK_SIZE = 5242880

    #
    # Upload zip file.
    #
    def self.upload(storage, opened_file, upload_path, name)
      storage.create(upload_path, opened_file) do |file|
        file.multipart_chunk_size = MULTIPART_CHUNK_SIZE
        file.content_disposition = "attachment; filename=\"#{name}.zip\""
      end
    end
  end
end