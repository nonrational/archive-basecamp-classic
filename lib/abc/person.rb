require "fileutils"

class Abc::Person < ActiveRecord::Base
  def self.fetch_all
    Basecamp::Person.all.each do |bp|
      attrs = bp.attributes.symbolize_keys
      Abc::Person.create_with(attrs.except(:id)).find_or_create_by(id: attrs[:id])
    end
  end
end
