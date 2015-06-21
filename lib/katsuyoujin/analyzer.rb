require 'kuromoji'
require 'mojinizer'

module Katsuyoujin
  class Analyzer
    attr_reader :word

    def initialize(word)
      @word = word
    end

    def verb
      analysis.detect do |part|
        part['parts_of_speech'].split(/\s*,\s*/).include? '動詞'
      end || {}
    end

    def base_form
      verb['base_form'].to_s
    end

    def base_form_hiragana
      verb['reading'].to_s.hiragana
    end

    def verb_category
      return nil unless base_form

      case
      when ['する'].include?(base_form_hiragana.chars.last(2).join) then 'irregular'
      when 'くる' == base_form_hiragana then 'irregular'
      when YAML.load_file(File.join(Katsuyoujin.rules, 'godan/iru_eru.yml')).include?(base_form_hiragana) then 'godan'
      when ['iru', 'eru'].include?(base_form_hiragana.romaji.chars.last(3).join) then 'ichidan'
      else 'godan'
      end
    end

    private

    def analysis
      @analysis ||= Kuromoji::Core.new.tokenize_with_hash word
    end
  end
end
