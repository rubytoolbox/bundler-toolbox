# frozen_string_literal: true

require "spec_helper"

RSpec.describe Bundler::Toolbox::CLI do
  around do |example|
    original = ENV["BUNDLER_TOOLBOX_ENVIRONMENT"]
    begin
      example.run
    ensure
      ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = original
    end
  end

  def invoke(*args)
    Dry::CLI.new(described_class).call arguments: args
  end

  describe ".execution_environment" do
    described_class::KNOWN_ENVIRONMENTS.each do |environment|
      it "returns #{environment} when BUNDLER_TOOLBOX_ENVIRONMENT is #{environment}" do
        ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = environment

        expect(described_class.execution_environment).to be == environment
      end
    end

    [nil, "foo", true, 42].each do |environment|
      it "returns 'unknown' when BUNDLER_TOOLBOX_ENVIRONMENT is #{environment.inspect}" do
        ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = environment.to_s

        expect(described_class.execution_environment).to be == "unknown"
      end
    end
  end

  describe ".with_environment" do
    it "raises ArgumentError when called with unknown env" do
      expect { described_class.with_environment("wat") }
        .to raise_error(ArgumentError, /Unknown environment/)
    end

    it "changes environment to given one for duration of the block" do
      block_env = nil

      chosen_env = described_class::KNOWN_ENVIRONMENTS.sample

      described_class.with_environment chosen_env do
        block_env = described_class.execution_environment
      end

      expect(block_env).to be == chosen_env
    end

    it "changes environment back to the previous after block has run" do
      ENV["BUNDLER_TOOLBOX_ENVIRONMENT"] = "bundler"

      described_class.with_environment("rubygems") { "do nothing" }

      expect(described_class.execution_environment).to be == "bundler"
    end
  end

  describe "Version Command" do
    it "prints version" do
      expect { invoke "version" }
        .to output(/^bundler-toolbox v#{Bundler::Toolbox::VERSION}/o)
        .to_stdout
    end

    it "prints ruby runtime context when invoked with --info" do
      expect { invoke "version", "--info" }
        .to output(/Ruby: #{Regexp.escape(RUBY_DESCRIPTION)}/o).to_stdout
    end

    it "prints gem execution environment when invoked with --info" do
      expect { invoke "version", "--info" }
        .to output(/Execution environment: #{described_class.execution_environment}/).to_stdout
    end
  end
end
