# frozen_string_literal: true

class Bundler::Toolbox::Plugins::Bundler < Bundler::Plugin::API
  command "toolbox"

  def exec(_command, args)
    Bundler::Toolbox::CLI.with_environment "bundler" do
      Dry::CLI.new(Bundler::Toolbox::CLI).call arguments: args
    end
  end
end
