# frozen_string_literal: true

require 'yaml'
require 'rubygems'
require 'bundler'
Bundler.require(:default)

Dotenv.load

require_relative '../config/connections'

require_relative 'db-bot/table_column_mapper'
require_relative 'db-bot/table_cache'
require_relative 'db-bot/hash_diff_formatter'
require_relative 'db-bot/slack_messenger'
require_relative 'db-bot/diff_finder'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end
