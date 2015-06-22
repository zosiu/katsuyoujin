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

  GODAN_IRU_ERU   = YAML.load_file(File.join(Katsuyoujin.rules, 'godan/iru_eru.yml')).freeze
  GODAN_KURU_SURU = YAML.load_file(File.join(Katsuyoujin.rules, 'godan/kuru_suru.yml')).freeze

  ICHIDAN_BASE_TABLE    = YAML.load_file File.join(Katsuyoujin.rules, 'ichidan/base.yml').freeze
  GODAN_BASE_TABLE      = YAML.load_file File.join(Katsuyoujin.rules, 'godan/base.yml').freeze
  IRREGULAR_BASE_TABLE  = YAML.load_file File.join(Katsuyoujin.rules, 'irregular/base.yml').freeze

  CONJUGATIONS = { 'ichidan' => YAML.load_file(File.join(rules, 'ichidan/conjugations.yml')).freeze,
                   'godan' => YAML.load_file(File.join(rules, 'godan/conjugations.yml')).freeze,
                   'irregular' => YAML.load_file(File.join(rules, 'irregular/conjugations.yml')).freeze }

  def self.conjugate(word, *args, category: nil, hiragana: true)
    verb = Verb.new word

    vcat = category || verb.category
    vcat = 'irregular' if ['kuru', 'suru'].include?(vcat)

    rules = args.inject(CONJUGATIONS[vcat]) { |conjugations, rule| conjugations[rule] || {} }
    return unless rules['base']

    base = Base.new(verb, rules['base']).conjugate category: category, hiragana: hiragana
    base + rules['attachment']
  end
end
