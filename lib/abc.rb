require 'dotenv/load'

require 'nokogiri'
require 'basecamp'
Basecamp.establish_connection!(ENV['BASECAMP_HOST'], ENV['BASECAMP_API_TOKEN'], 'x')

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)
db_config = YAML::load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

module Abc
end
