## CloudArchiver
Downloads files, uses RubyZip gem to zip them together and uploads zipped file to a given upload path. Currently teste only with S3.

## Usage

    # Create a new instance
    
    cloud_arciver = CloudArchiver.new({
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


On a successful archiving and upload CloudArchiver::ArchiveFile object will be returned which includes list of CloudArchiver::StorageFile objects (files in the archive) and Fog File object of the archive.