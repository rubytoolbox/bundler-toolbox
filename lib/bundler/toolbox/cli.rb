# frozen_string_literal: true

require "dry/cli"

module Bundler
  module Toolbox
    module CLI
      extend Dry::CLI::Registry

      class << self
        def execution_environment
          case ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]&.strip
          when "standalone"
            "standalone"
          when "bundler"
            "bundler"
          when "rubygems"
            "rubygems"
          else
            "unknown"
          end
        end

        def with_environment(new_environment)
          old_environment = ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]
          ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = new_environment
          yield
        ensure
          ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = old_environment
        end
      end

      class Version < Dry::CLI::Command
        desc "Print version"

        option :info, type: :boolean,
                      default: false,
                      desc: "Show additional environment information"

        def call(info: false, **)
          puts "bundler-toolbox v#{Bundler::Toolbox::VERSION}"

          return unless info

          puts
          puts "Ruby: #{RUBY_DESCRIPTION}"
          puts "Execution environment: #{Bundler::Toolbox::CLI.execution_environment}"
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]
    end
  end
end
