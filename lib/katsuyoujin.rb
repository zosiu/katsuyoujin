require 'yaml'

require 'katsuyoujin/version'
require 'katsuyoujin/verb'
require 'katsuyoujin/base'
require 'katsuyoujin/analyzer'

module Katsuyoujin
  def self.conjugate(word, *args, category: nil, hiragana: true)
    verb = Verb.new word

    vcat = category || verb.category
    vcat = 'irregular' if ['kuru', 'suru'].include?(vcat)

    rules = args.inject(ruleset("#{vcat}/conjugations")) { |a, e| a[e] || {} }
    return unless rules['base']

    base = Base.new(verb, rules['base']).conjugate category: category, hiragana: hiragana
    base + rules['attachment']
  end

  def self.ruleset(rule)
    YAML.load_file(File.join(File.dirname(__dir__), 'rules', "#{rule}.yml"))
  end
end
