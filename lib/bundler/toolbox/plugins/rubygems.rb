# frozen_string_literal: true

require "bundler-toolbox"

class Gem::Commands::ToolboxCommand < Gem::Command
  def initialize
    super("toolbox", "Hello World")
  end

  def execute
    Bundler::Toolbox::CLI.with_environment "rubygems" do
      Dry::CLI.new(Bundler::Toolbox::CLI).call arguments: @options[:args]
    end
  end

  #
  # We have to override this handler because otherwise rubygem's own
  # dynamically created option parser will interfere with the actual CLI
  # options
  #
  def handle_options(args)
    @options[:args] = args
  end
end
