## CloudArchiver
Downloads files, creates an archive and uploads archive to a given upload location. 

Uses [Fog](https://github.com/fog/fog) for downloading and uploading files and [RubyZip](https://github.com/rubyzip/rubyzip) to zip files.

Currently tested only with AWS.

## Usage

    # Create a new instance
    cloud_archiver = CloudArchiver.new({
        provider: 'AWS', 
        aws_access_key_id: 	'YOUR_AWS_ACCESS_KEY_ID', 
        aws_secret_access_key: 	'YOUR_AWS_SECRET_ACCESS_KEY', 
        bucket: 'BUCKET'
    })
    
    # Call archive method and provide following arguments: 
    # * array of files (name of the file, path to the file) which will be zipped
    # * unique key for the archive
    # * name for the archive
    # * path where archive will be uploaded
    cloud_archiver.archive(
    	[{ 
    		name: "NAME_OF_THE_FILE", 
    		remote_path: "PATH_TO_THE_FILE" 
    	}], 
    	'UNIQUE_KEY_FOR_THE_ARCHIVE', 
    	'NAME_OF_THE_ARCHIVE', 
    	'PATH_WHERE_ARCHIVE_WILL_BE_UPLOADED'
    )


When successful, CloudArchiver::ArchiveFile object will be returned which includes array of CloudArchiver::StorageFile objects (files in the archive) and Fog File object of the archive.