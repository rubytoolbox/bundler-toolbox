# frozen_string_literal: true

require "pry"

When("I open pry") do
  binding.pry # rubocop:disable Lint/Debugger uhm yes
end
