require "pry"
require "nokogiri"
require "httparty"

class BasecampClient
  include HTTParty
  # debug_output $stdout

  base_uri("https://" + ENV.fetch("BASECAMP_HOST"))
  headers({
    "User-Agent" => "Archive Basecamp Classic (https://github.com/nonrational/archive-basecamp-classic)"
  })
  basic_auth(ENV.fetch("BASECAMP_API_TOKEN"), "x")
end
