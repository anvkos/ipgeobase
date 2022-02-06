# frozen_string_literal: true

require 'net/http'
require 'addressable/uri'
require 'happymapper'
require_relative 'ipgeobase/version'

module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    url = "http://ip-api.com/xml/#{ip}"
    uri = Addressable::URI.parse(url)
    res = Net::HTTP.get_response(uri)
    return nil unless res.is_a?(Net::HTTPSuccess)

    HappyMapper.parse(res.body)
  end
end
