module Katsuyoujin
  class Base
    attr_reader :verb, :base_letter

    def initialize(verb, base_letter)
      @verb = verb
      @base_letter = base_letter
    end

    def conjugate(category: nil, hiragana: true)
      case category || verb.category
      when 'ichidan' then ichidan_base(base_letter, hiragana: hiragana)
      when 'godan' then godan_base(base_letter, hiragana: hiragana)
      when 'suru', 'kuru' then irregular_base(base_letter, hiragana: hiragana)
      end
    end

    private

    def ichidan_base(base_letter, hiragana: true)
      verb_root(hiragana) + ICHIDAN_BASE_TABLE[base_letter]
    end

    def godan_base(base_letter, hiragana: true)
      verb_root(hiragana) + GODAN_BASE_TABLE[base_letter][verb.ending]
    end

    def irregular_base(base_letter, hiragana: true)
      IRREGULAR_BASE_TABLE[base_letter][verb.hiragana_ending][hiragana ? 'hiragana' : 'kanji']
    end

    def verb_root(hiragana = true)
      hiragana ? verb.hiragana_root : verb.root
    end
  end
end
