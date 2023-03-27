require "fileutils"

class Abc::Person < ActiveRecord::Base
  def self.fetch_all
    Basecamp::Person.all
  end
end
