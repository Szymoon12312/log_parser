# frozen_string_literal: true

require 'helpers'
require 'presenter'

describe Presenter do
  include Helpers

  let(:log) { load_yml(:unordered_parsed_log) }

  shared_examples 'invalid log' do
    context 'when empty log object provided' do
      let(:log) {}

      it 'prints default line' do
        expect { subject }.to output("Log has no valid lines\n").to_stdout
      end
    end
  end

  describe '#list_by_visits' do
    subject { Presenter.new(log).list_by_visits }

    it_behaves_like 'invalid log'

    it 'prints list sorted by visits count' do
      expect { subject }.to output(
        <<~LOG
          test/1 - Number of visits: 10
          test/3 - Number of visits: 2
        LOG
      ).to_stdout
    end
  end

  describe '#list_by_uniq_visits' do
    subject { Presenter.new(log).list_by_uniq_visits }

    it_behaves_like 'invalid log'

    it 'prints list sorted by unique visits count' do
      expect { subject }.to output(
        <<~LOG
          test/3 - Number of unique visits: 2
          test/1 - Number of unique visits: 1
        LOG
      ).to_stdout
    end
  end
end
