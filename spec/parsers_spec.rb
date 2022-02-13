# frozen_string_literal: true

require 'helpers'
require 'parser'

describe Parser do
  include Helpers

  subject { Parser.call(path:) }

  context 'when file not found' do
    let(:path) { '' }

    it 'raises FileNotExists' do
      expect { subject }.to raise_error(FileNotExists)
    end
  end

  context 'when file is empty' do
    let(:path) { log_file_path(:empty_log) }

    it 'raises EmptyFile' do
      expect { subject }.to raise_error(EmptyFile)
    end
  end

  context 'when file exists' do
    context 'when log file match pattern' do
      let(:path) { log_file_path(:test_log) }

      it 'prase log file' do
        expect(subject).to match(
          '/test2' => {
            uniq_addresses: ['111.111.111.112'],
            visit_count: 2,
            uniq_visit_count: 1
          },
          '/test/3' => {
            uniq_addresses: ['111.111.111.111', '111.111.111.112'],
            visit_count: 4,
            uniq_visit_count: 2
          }
        )
      end
    end

    context 'when log file dose not match pattern' do
      let(:path) { log_file_path(:faulty_log) }

      it 'returns empty object' do
        expect(subject).to be_empty
      end
    end
  end
end
