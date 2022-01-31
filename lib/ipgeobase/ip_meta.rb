# frozen_string_literal: true

module Ipgeobase
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
