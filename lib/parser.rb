# frozen_string_literal: true

require 'set'

class FileNotExists < StandardError; end
class EmptyFile < StandardError; end

# This class is responsible for parsing log files into visits statistic Hash.
# @param [String] path The path to file.
# @returns [Hash] the parsed log entries.
# @example
#  Parser.call('./path.txt')
#  => { 'test/1' => { visit_count: 1, uniq_addresses: '111.111.111.111', uniq_visit_count: 1 } }
class Parser
  # Could be improved by adding a stricter IP lookup.
  LOG_LINE_REGEXP = %r{^(?<path>/[A-za-z0-9/]+)\s(?<ip>[0-9.]+)$}

  def initialize(path:)
    @path = path
    @result = Hash.new do |hash, key|
      hash[key] = { visit_count: 0, uniq_addresses: Set[], uniq_visit_count: 0 }
    end
  end

  def self.call(path:)
    raise FileNotExists unless File.exist?(path)
    raise EmptyFile if File.zero?(path)

    new(path:).send(:call)
  end

  private

  attr_reader :path
  attr_accessor :result

  def call
    parse_file

    result
  end

  def parse_file
    IO.readlines(path).each { parse_line(_1) }
  end

  def parse_line(line)
    # For simplicity there is no action on faulty lines. Could collect and log them later or raise an exception.
    return unless (match = line.match(LOG_LINE_REGEXP))

    result[match[:path]][:uniq_visit_count] += 1 unless result[match[:path]][:uniq_addresses].include?(match[:ip])
    result[match[:path]][:visit_count] += 1
    result[match[:path]][:uniq_addresses] << match[:ip]
  end
end
