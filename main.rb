#!/usr/bin/env ruby
require_relative 'models/checkout'

cmd_handler = CommandHandler.new
cmd_handler.perform
