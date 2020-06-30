# frozen_string_literal: true

require "bundler/toolbox/version"
require "bundler/toolbox/plugins"
require "bundler/toolbox/cli"
require "rubytoolbox/api"
require "json"

module Bundler
  module Toolbox
    class Error < StandardError; end

    class FixtureAdapter
      attr_accessor :base_path
      private :base_path=

      def initialize(base_path: File.join(__dir__, "..", "..", "fixtures"))
        self.base_path = base_path
      end

      def compare(*projects)
        projects.map { |project| response_from_fixture(project) }.compact
      end

      private

      def response_from_fixture(project)
        data = JSON.parse File.read(File.join(base_path, "#{project}.json"))

        Rubytoolbox::Api::Project.new(data)
      # The API omits unknown projects from the collection response
      rescue Errno::ENOENT
        nil
      end
    end

    class << self
      def compare(*projects, fixtures: false)
        adapter(fixtures: fixtures).compare(*projects)
      end

      def adapter(fixtures: false)
        if fixtures
          FixtureAdapter.new
        else
          Rubytoolbox::Api.new
        end
      end
    end
  end
end
