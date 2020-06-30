# frozen_string_literal: true

require "dry/cli"
require "liquid"

module Bundler
  module Toolbox
    module CLI
      extend Dry::CLI::Registry

      KNOWN_ENVIRONMENTS = %w[standalone bundler rubygems].freeze

      class << self
        def execution_environment
          if KNOWN_ENVIRONMENTS.include? ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]
            ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]
          else
            "unknown"
          end
        end

        def with_environment(new_environment)
          unless KNOWN_ENVIRONMENTS.include? new_environment
            raise ArgumentError, "Unknown environment #{new_environment}! Known: #{KNOWN_ENVIRONMENTS.inspect}"
          end

          old_environment = ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]
          ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = new_environment

          begin
            yield
          ensure
            ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = old_environment
          end
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

      class About < Dry::CLI::Command
        desc "Get information about given gem(s)"

        argument :gems, type: :array,
                        required: true,
                        desc: "Name(s) of gems to print information about"

        option :fixtures, type: :boolean,
                          default: false,
                          desc: "For testing purposues: Do not make actual API calls, use local fixtures"

        def call(gems:, fixtures:, **)
          Bundler::Toolbox.compare(*gems, fixtures: fixtures).each do |project|
            puts format_project(project)
          end
        end

        private

        def template_path(filename)
          File.join(__dir__, "..", "..", "..", "templates", filename)
        end

        def template
          @template ||= Liquid::Template.parse File.read(template_path("about.liquid"))
        end

        def format_project(project)
          template.render(project.to_h)
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]
      register "about", About, aliases: ["a"]
    end
  end
end
