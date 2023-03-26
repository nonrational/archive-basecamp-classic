# Rakefile
require "bundler/setup"
Bundler.require
require "json"
require "yaml"

require "active_record"
require "dotenv/load"
require "nokogiri"
require "sqlite3"

def load_and_initialize
  path = File.expand_path("..", __FILE__)
  Dir.glob("#{path}/**/*.rb") { |f|
    puts f
    load f
  }

  # ActiveRecord::Base.logger = Logger.new(STDERR)
  db_config = YAML.load(File.open("config/database.yml"))
  ActiveRecord::Base.establish_connection(db_config)
end

namespace :basecamp do
  task :run do
    load_and_initialize
    BasecampProjectAttachmentIterator.default.fetch_all
  end

  task :download do
    load_and_initialize
    Attachment.download_all
  end
end

namespace :db do
  db_config = YAML.load(File.open("config/database.yml"))

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config)
    puts "Database created"
  end

  desc "Migrate the database"
  task migrate: :create do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration).migrate
    puts "Database migrated"
  end

  desc "Drop the database"
  task :drop do
    File.delete(db_config["database"]) if File.exist?(db_config["database"])
    puts "Database deleted"
  end

  desc "Reset the database"
  task reset: [:drop, :create, :migrate]

  desc "Create a db/schema.rb file"
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require "active_record/schema_dumper"
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
    puts "Schema dumped"
  end

  desc "Populate the database"
  task seed: :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    load "db/seed.rb" if File.exist?("db/seed.rb")
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.write(path, <<~EOF)
      class #{migration_class} < ActiveRecord::Migration[6.0]
        def change
        end
      end
    EOF

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
