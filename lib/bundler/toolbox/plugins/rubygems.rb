# frozen_string_literal: true

class Gem::Commands::ToolboxCommand < Gem::Command
  def initialize
    super "toolbox", "Hello World"
  end

  def execute
    puts "Rubygems plugin integration works!"
  end
end
