namespace :heroku do
  desc "Example showing PostgreSQL database backups from Heroku to Amazon S3"
  task :backup => :environment do
    require 'heroku-s3-backup-zinergia'
    HerokuDatabaseBackupToS3.backup
  end
end
