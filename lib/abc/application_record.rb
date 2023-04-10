require "csv"

class Abc::ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.export_all_to_csv
    FileUtils.mkdir_p "projects"
    CSV.open(path, "w") do |writer|
      writer << first.attributes.map { |a, v| a }
      all.each do |s|
        writer << s.attributes.map { |a, v| v }
      end
    end

    path
  end

  def self.path
    "projects/#{table_name}.csv"
  end
end
