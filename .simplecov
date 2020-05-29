# frozen_string_literal: true

SimpleCov.start do
  enable_coverage :branch
  minimum_coverage line: 100, branch: 90 unless ENV["SKIP_COVERAGE"]
end
