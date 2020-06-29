# frozen_string_literal: true

require "rubygems/command_manager"
require "bundler/toolbox/plugins/rubygems"

Gem::CommandManager.instance.register_command :toolbox
