require "fileutils"

class Abc::Project < Abc::ApplicationRecord
  def self.fetch_all
    Abc::Project.delete_all

    BasecampClient.get("/projects.xml")["projects"].each do |p|
      attrs = p.symbolize_keys.except(:company)
      attrs[:company_id] = p["company"]["id"]
      attrs[:company_name] = p["company"]["name"]

      Abc::Project.create_with(attrs.except(:id)).find_or_create_by(id: attrs[:id])
    end
  end

  def self.fetch_all_todos
    all.each { |p| p.fetch_todos }
  end

  def fetch_todos
    BasecampClient.get("/projects/#{id}/todo_lists.xml")["todo_lists"].each do |t|
      attrs = t.symbolize_keys.except(:complete)
      Abc::Todo.create_with(attrs.except(:id)).find_or_create_by(id: attrs[:id])
    end
  end
end
