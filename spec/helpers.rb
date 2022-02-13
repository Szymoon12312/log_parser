# frozen_string_literal: true

require 'yaml'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

module Helpers
  def log_file_path(file)
    "#{__dir__}/fixtures/#{file}.txt"
  end

  def load_yml(file)
    YAML.safe_load(File.read("#{__dir__}/fixtures/#{file}.yml"), permitted_classes: [Symbol])
  end
end
