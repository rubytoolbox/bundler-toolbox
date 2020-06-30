# frozen_string_literal: true

SimpleCov.start do
  # JRuby is making some issues on CI, but it should generally suffice to enforce 100% on MRI regardless
  minimum_coverage 100 unless RUBY_ENGINE == "jruby"
end
