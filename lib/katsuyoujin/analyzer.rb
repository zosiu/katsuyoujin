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
      fail ArgumentError('not a verb') unless base_form

      case
      when irregular_godan? then 'godan'
      when suru? then 'suru'
      when kuru? then 'kuru'
      when ichidan? then 'ichidan'
      else 'godan'
      end
    end

    private

    def suru?
      'する' == base_form_hiragana
    end

    def kuru?
      'くる' == base_form_hiragana
    end

    def godan_iru_eru?
      GODAN_IRU_ERU.include?(base_form_hiragana)
    end

    def godan_kuru_suru?
      GODAN_KURU_SURU.include?(base_form)
    end

    def irregular_godan?
      godan_iru_eru? || godan_kuru_suru?
    end

    def ichidan?
      ['iru', 'eru'].include? base_form_hiragana.romaji.chars.last(3).join
    end

    def analysis
      @analysis ||= Kuromoji::Core.new.tokenize_with_hash word
    end
  end
end
