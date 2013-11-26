require 'zip'
require 'cloud_archiver/storage_file'

class CloudArchiver
  #
  # Archive given files into zip.
  #
  module Archiver
    def self.pack(storage, stream_path, files)
      Zip::OutputStream.open(stream_path) do |zip|
        files.each do |file|
          zip.put_next_entry(file[:name], nil, nil, Zip::Entry::DEFLATED, Zlib::NO_COMPRESSION)
          remote_stream = StorageFile.new(storage, file[:remote_path])
          remote_stream.each_chunk { |chunk| zip << chunk }
        end
      end
    end
  end
end