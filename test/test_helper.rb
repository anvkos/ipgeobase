# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'ipgeobase'

require 'bundler/setup'
Bundler.require

require 'minitest/autorun'
require 'webmock/minitest'

def read_fixture_file(filename)
  File.read(
    File.join(
      File.expand_path("fixtures", File.dirname(__FILE__)),
      filename
    )
  )
end
