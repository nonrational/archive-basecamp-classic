require "dotenv/load"

require "nokogiri"
require "basecamp"
require "sqlite3"
require "active_record"

module Abc
  def self.boot!
    Basecamp.establish_connection!(ENV.fetch("BASECAMP_HOST"), ENV.fetch("BASECAMP_API_TOKEN"), "x")

    ActiveRecord::Base.logger = Logger.new($stderr)
    db_config = YAML.load(File.open("config/database.yml"))
    ActiveRecord::Base.establish_connection(db_config)
  end
end

Abc.boot!
