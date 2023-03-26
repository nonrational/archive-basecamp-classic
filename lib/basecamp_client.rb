#!/usr/bin/env ruby

require "pry"
require "nokogiri"
require "httparty"

class BasecampClient
  include HTTParty

  base_uri "https://#{ENV.fetch("BASECAMP_HOST")}"
  headers({
    "Content-Type" => "application/xml",
    "Accept" => "application/xml"
  })
  basic_auth ENV.fetch("BASECAMP_API_TOKEN"), "x"
end
