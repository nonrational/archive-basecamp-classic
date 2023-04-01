#!/usr/bin/env ruby

require "pry"
require "nokogiri"
require "httparty"

class BasecampClient
  include HTTParty

  base_uri "https://#{ENV.fetch("BASECAMP_HOST")}"
  headers({
    "User-Agent" => "Archive Basecamp Classic (https://github.com/nonrational/archive-basecamp-classic)",
    "Content-Type" => "application/xml",
    "Accept" => "application/xml"
  })
  basic_auth ENV.fetch("BASECAMP_API_TOKEN"), "x"
end
