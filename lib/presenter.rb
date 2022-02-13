# frozen_string_literal: true

# Lists to STDOUT sorted log entries.
# @param [Hash<String,Hash>] statistics Hash with path as key and statistics hash as value.
# @example
# Presenter.new({ '/tets' => { visit_count: 1, uniq_addresses: ['111.111.111'], uniq_visit_count: 1 } }).list_by_views
# > /tets - Number of views: 1
# > => [["/tets", {:visit_count=>1, :uniq_addresses=>["111.111.111"], :uniq_visit_count=>1}]]
class Presenter
  def initialize(statistics = {})
    @statistics = statistics
  end

  def list_by_visits
    return empty_log_message if statistics.nil? || statistics.empty?

    # For performance improvements we could build an array display whole statistics at once.
    sorted_by_views.each do |path, data|
      puts "#{path} - Number of visits: #{data[:visit_count]}"
    end
  end

  def list_by_uniq_visits
    return empty_log_message if statistics.nil? || statistics.empty?

    # For performance improvements we could build an array and display whole statistics at once.
    sorted_by_uniq_views.each do |path, data|
      puts "#{path} - Number of unique visits: #{data[:uniq_visit_count]}"
    end
  end

  private

  attr_reader :statistics

  def sorted_by_views
    @sorted_by_views ||= statistics.sort_by { -_2[:visit_count] }
  end

  def sorted_by_uniq_views
    @sorted_by_uniq_views ||= statistics.sort_by { -_2[:uniq_visit_count] }
  end

  def empty_log_message
    puts 'Log has no valid lines'
  end
end
