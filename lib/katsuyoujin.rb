require 'yaml'

require 'katsuyoujin/version'
require 'katsuyoujin/verb'
require 'katsuyoujin/base'
require 'katsuyoujin/analyzer'

module Katsuyoujin
  def self.root
    File.dirname __dir__
  end

  def self.rules
    File.join root, 'rules'
  end

  ICHIDAN_BASE_TABLE  = YAML.load_file File.join(Katsuyoujin.rules, 'ichidan/base.yml').freeze
  GODAN_BASE_TABLE    = YAML.load_file File.join(Katsuyoujin.rules, 'godan/base.yml').freeze

  CONJUGATIONS = { 'ichidan' => YAML.load_file(File.join(rules, 'ichidan/conjugations.yml')).freeze,
                   'godan' => YAML.load_file(File.join(rules, 'godan/conjugations.yml')).freeze }

  def self.conjugate(word, *args, category: nil, hiragana: true)
    verb = Verb.new word

    vcat = category || verb.category
    rules = args.inject(CONJUGATIONS[vcat]) { |conjugations, rule| conjugations[rule] || {} }
    return unless rules['base']

    base = Base.new(verb, rules['base']).conjugate category: category, hiragana: hiragana
    base + rules['attachment']
  end
end
