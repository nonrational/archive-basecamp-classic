require "fileutils"

class Abc::Todo < Abc::ApplicationRecord
  belongs_to :project
end
