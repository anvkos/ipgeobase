# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_ip_contains_meta_data
    ip = '185.117.121.99'
    expected_attributes = {
      city: 'Antalya',
      country: 'Turkey',
      countryCode: 'TR',
      lat: '36.9094',
      lon: '30.6946'
    }

    body = <<~HEREDOC
      <?xml version="1.0" encoding="UTF-8"?>
      <query>
        <status>success</status>
        <country>Turkey</country>
        <countryCode>TR</countryCode>
        <region>07</region>
        <regionName>Antalya</regionName>
        <city>Antalya</city>
        <zip>27500</zip>
        <lat>36.9094</lat>
        <lon>30.6946</lon>
        <timezone>Europe/Istanbul</timezone>
        <isp>Fibim Fibernet GSM Sanayi VE Ticaret Anonim Sirketi</isp>
        <org>Fibim Fibernet GSM Sanayi VE Ticaret Anonim Sirketi</org>
        <as>AS213145 FIBIM FIBERNET GSM SANAYI VE TICARET ANONIM SIRKETI</as>
        <query>185.117.121.99</query>
      </query>
    HEREDOC
    url = "http://ip-api.com/xml/#{ip}"
    stub_test_request(url, body)

    ip_meta = Ipgeobase.lookup(ip)

    assert_equal expected_attributes[:city], ip_meta.city
    assert_equal expected_attributes[:country], ip_meta.country
    assert_equal expected_attributes[:countryCode], ip_meta.countryCode
    assert_equal expected_attributes[:lat], ip_meta.lat
    assert_equal expected_attributes[:lon], ip_meta.lon
  end

  def test_other_ip_contains_another_meta_data
    ip = '8.8.8.8'
    expected_attributes = {
      city: 'Ashburn',
      country: 'United States',
      countryCode: 'US',
      lat: '39.03',
      lon: '-77.5'
    }
    body = <<~HEREDOC
      <?xml version="1.0" encoding="UTF-8"?>
      <query>
        <status>success</status>
        <country>United States</country>
        <countryCode>US</countryCode>
        <region>VA</region>
        <regionName>Virginia</regionName>
        <city>Ashburn</city>
        <zip>20149</zip>
        <lat>39.03</lat>
        <lon>-77.5</lon>
        <timezone>America/New_York</timezone>
        <isp>Google LLC</isp>
        <org>Google Public DNS</org>
        <as>AS15169 Google LLC</as>
        <query>8.8.8.8</query>
      </query>
    HEREDOC
    url = "http://ip-api.com/xml/#{ip}"
    stub_test_request(url, body)

    ip_meta = Ipgeobase.lookup(ip)

    assert_equal expected_attributes[:city], ip_meta.city
    assert_equal expected_attributes[:country], ip_meta.country
    assert_equal expected_attributes[:countryCode], ip_meta.countryCode
    assert_equal expected_attributes[:lat], ip_meta.lat
    assert_equal expected_attributes[:lon], ip_meta.lon
  end

  protected

  def stub_test_request(url, body)
    stub_request(:get, url).
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: body, headers: {})
  end
end
