class HerokuDatabaseBackupToS3
  
  def self.create_bucket_if_it_does_not_exist(bucket_name)
    AWS::S3::Bucket.find(bucket_name)
  rescue AWS::S3::NoSuchBucket => e
    puts "Bucket '#{bucket_name}' does not exist. Creating it..."
    AWS::S3::Bucket.create(bucket_name)
  end
  
  def self.backup
    begin
      require 'aws/s3'
      puts "[#{Time.now}] heroku:backup started"
      name = "#{ENV['APP_NAME']}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.dump"
      db_database_url = ENV['DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
      db_shared_database_url = ENV['SHARED_DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)

      [db_database_url, db_shared_database_url].each do |db|
        system "PGPASSWORD=#{db[2]} pg_dump -Fc --username=#{db[1]} --host=#{db[3]} #{db[4]} > tmp/#{name}"
        bucket_name = "#{ENV['APP_NAME']}-heroku-backups"
        AWS::S3::Base.establish_connection!(
              :access_key_id     => ENV['s3_access_key_id'],
              :secret_access_key => ENV['s3_secret_access_key']
            )
        create_bucket_if_it_does_not_exist(bucket_name)
      
        AWS::S3::S3Object.store(name, open("tmp/#{name}"), bucket_name, :access => :private)
      
        # s3 = RightAws::S3.new(ENV['s3_access_key_id'], ENV['s3_secret_access_key'])
        # bucket = s3.bucket("#{ENV['APP_NAME']}-heroku-backups", true, 'private')
        # bucket.put(name, open("tmp/#{name}"))
        system "rm tmp/#{name}"
        puts "[#{Time.now}] heroku:backup complete"
      end
    end
  end
end