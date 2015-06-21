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

    def ending
      dictionary_form[-1]
    end

    def root
      dictionary_form.chomp ending
    end

    def hiragana_root
      dictionary_form_hiragana.chomp ending
    end
  end
end
