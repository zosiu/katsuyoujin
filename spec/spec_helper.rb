require 'simplecov-gem-profile'
require 'codeclimate-test-reporter'
SimpleCov.start 'gem' if ENV['COVERAGE']
CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

require 'katsuyoujin'
require_relative 'support/shared_examples_for_conjugations'

BASE_CATEGORIES = ['あ', 'い', 'う', 'え', 'お', 'て', 'た'].freeze
ICHIDAN_BASES = YAML.load_file('spec/fixtures/ichidan/base.yml').freeze

BASES = { 'ichidan' => YAML.load_file('spec/fixtures/ichidan/base.yml'),
          'godan' => YAML.load_file('spec/fixtures/godan/base.yml'),
          'irregular' => YAML.load_file('spec/fixtures/irregular/base.yml') }.freeze

ICHIDAN_CONJUGATIONS = YAML.load_file('spec/fixtures/ichidan/conjugations.yml').freeze

GODAN_ENDINGS = ['す', 'く', 'ぐ', 'ぶ', 'む', 'ぬ', 'る', 'つ', 'う']

GODAN_CONJUGATIONS = GODAN_ENDINGS.each_with_object({}) do |ending, hsh|
  hsh[ending] = YAML.load_file("spec/fixtures/godan/#{ending.romaji}_conjugations.yml")
end.freeze

IRREGULAR_CONJUGATIONS = YAML.load_file('spec/fixtures/irregular/conjugations.yml').freeze

CONJUGATION_TYPES = ['nonpast_indicative',
                     'past_indicative',
                     'volitional'].freeze

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.mock_with :rspec

  config.order = 'random'
end
