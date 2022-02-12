# frozen_string_literal: true

require 'test_helper'

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_ip_contains_meta_data
    ip = '185.117.121.99'
    expected_attributes = {
      city: 'Antalya',
      country: 'Turkey',
      country_code: 'TR',
      lat: 36.9094,
      lon: 30.6946
    }
    body = read_fixture_file("#{ip}.xml")
    url = "http://ip-api.com/xml/#{ip}"
    stub_test_request(url, body)

    ip_meta = Ipgeobase.lookup(ip)

    assert_equal expected_attributes[:city], ip_meta.city
    assert_equal expected_attributes[:country], ip_meta.country
    assert_equal expected_attributes[:country_code], ip_meta.country_code
    assert_equal expected_attributes[:lat], ip_meta.lat
    assert_equal expected_attributes[:lon], ip_meta.lon
  end

  def test_other_ip_contains_another_meta_data
    ip = '8.8.8.8'
    expected_attributes = {
      city: 'Ashburn',
      country: 'United States',
      country_code: 'US',
      lat: 39.03,
      lon: -77.5
    }
    body = read_fixture_file("#{ip}.xml")
    url = "http://ip-api.com/xml/#{ip}"
    stub_test_request(url, body)

    ip_meta = Ipgeobase.lookup(ip)

    assert_equal expected_attributes[:city], ip_meta.city
    assert_equal expected_attributes[:country], ip_meta.country
    assert_equal expected_attributes[:country_code], ip_meta.country_code
    assert_equal expected_attributes[:lat], ip_meta.lat
    assert_equal expected_attributes[:lon], ip_meta.lon
  end

  protected

  def stub_test_request(url, body)
    stub_request(:get, url)
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: body, headers: {})
  end
end
