# frozen_string_literal: true

class Bundler::Toolbox::Plugins::Bundler < Bundler::Plugin::API
  command "toolbox"

  def exec(command, args)
    puts "Bundler plugin integration works!"
    puts "You called " + command + " with args: " + args.inspect
  end
end
