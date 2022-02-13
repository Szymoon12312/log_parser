# frozen_string_literal: true

require_relative('lib/parser')
require_relative('lib/presenter')

DEFAULT_PATH = 'webserver.txt'

parsed_log = Parser.call(path: ARGV[0] || DEFAULT_PATH)
presenter = Presenter.new(parsed_log)

puts
puts 'List by visit count:'
puts

presenter.list_by_visits

puts
puts 'List by unique visit count:'
puts

presenter.list_by_uniq_visits
