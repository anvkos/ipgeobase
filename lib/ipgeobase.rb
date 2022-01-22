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

    body = HappyMapper.parse(res.body)
    IpMeta.new(city: body.city, country: body.country, country_code: body.country_code, lat: body.lat, lon: body.lon)
  end

  class IpMeta
    attr_reader :city, :country, :country_code, :lat, :lon

    def initialize(params = {})
      @city = params[:city]
      @country = params[:country]
      @country_code = params[:country_code]
      @lat = params[:lat]
      @lon = params[:lon]
    end
  end
end
