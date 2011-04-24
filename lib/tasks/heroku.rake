namespace :heroku do
  desc "Example showing PostgreSQL database backups from Heroku to Amazon S3"
  task :backup => :environment do
    HerokuDatabaseBackupToS3.backup
  end
end
