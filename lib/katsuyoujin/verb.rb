module Katsuyoujin
  class Verb
    def initialize(word)
      @analyzer = Analyzer.new word
    end

    def dictionary_form
      @analyzer.base_form
    end

    def dictionary_form_hiragana
      @analyzer.base_form_hiragana
    end

    def category
      @analyzer.verb_category
    end

    def irregular?
      ['kuru', 'suru'].include? category
    end

    def ending
      irregular? ? dictionary_form[-2..-1] : dictionary_form[-1]
    end

    def hiragana_ending
      case category
      when 'suru' then 'する'
      when 'kuru' then 'くる'
      else ending
      end
    end

    def root
      dictionary_form.chomp ending
    end

    def hiragana_root
      dictionary_form_hiragana.chomp hiragana_ending
    end
  end
end
