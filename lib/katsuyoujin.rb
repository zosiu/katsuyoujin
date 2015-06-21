require 'yaml'

require 'katsuyoujin/version'
require 'katsuyoujin/verb'
require 'katsuyoujin/base'
require 'katsuyoujin/analyzer'

module Katsuyoujin
  CONJUGATIONS = { 'ichidan' => YAML.load_file('rules/ichidan/conjugations.yml'),
                   'godan' => YAML.load_file('rules/godan/conjugations.yml') }

  def self.conjugate(word, *args, category: nil, hiragana: true)
    verb = Verb.new word

    vcat = category || verb.category
    rules = args.inject(CONJUGATIONS[vcat]) { |conjugations, rule| conjugations[rule] || {} }
    return unless rules['base']

    base = Base.new(verb, rules['base']).conjugate category: category, hiragana: hiragana
    base + rules['attachment']
  end
end
