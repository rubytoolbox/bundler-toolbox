# frozen_string_literal: true

require "aruba/cucumber"

Aruba.configure do |config|
  # Mostly for jruby
  config.io_wait_timeout = 5
end
