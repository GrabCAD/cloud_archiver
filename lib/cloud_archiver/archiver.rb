require 'zip'
require 'cloud_archiver/storage_file'

Zip.unicode_names = true

class CloudArchiver
  #
  # Archive given files into zip.
  #
  module Archiver
    def self.pack(storage, stream_path, files)
      zipped_files = []

      Zip::OutputStream.open(stream_path) do |zip|
        files.each do |file|
          zip.put_next_entry(file[:name], nil, nil, Zip::Entry::DEFLATED, Zlib::NO_COMPRESSION)
          remote_stream = StorageFile.new(file[:remote_path])
          remote_stream.each_chunk(storage) { |chunk| zip << chunk }
          zipped_files << remote_stream
        end
      end
      return zipped_files
    end
  end
end
