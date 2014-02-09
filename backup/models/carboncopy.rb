
# encoding: utf-8

##
# Backup Generated: carboncopy
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t carboncopy [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:carboncopy, 'Create a backup of database') do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = "my_database_name"
    db.username           = "my_username"
    db.password           = "my_password"
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
    # When dumping all databases, `skip_tables` and `only_tables` are ignored.
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]
    db.additional_options = ["-xc", "-E=utf8"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = "my_access_key_id"
    s3.secret_access_key = "my_secret_access_key"
    # Or, to use a IAM Profile:
    # s3.use_iam_profile = true

    s3.region            = "us-east-1"
    s3.bucket            = "bucket-name"
    s3.path              = "path/to/backups"
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 5
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "sender@email.com"
    mail.to                   = "receiver@email.com"
    mail.address              = "smtp.gmail.com"
    mail.port                 = 587
    mail.domain               = "your.host.name"
    mail.user_name            = "sender@email.com"
    mail.password             = "my_password"
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

  ##
  # Hipchat [Notifier]
  #
  notify_by Hipchat do |hipchat|
    hipchat.on_success = true
    hipchat.on_warning = true
    hipchat.on_failure = true

    hipchat.token          = "token"
    hipchat.from           = "DB Backup"
    hipchat.rooms_notified = ["activity"]
    hipchat.success_color  = "green"
    hipchat.warning_color  = "yellow"
    hipchat.failure_color  = "red"
  end

end
