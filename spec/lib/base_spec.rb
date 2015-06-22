describe 'base' do
  BASE_CATEGORIES.each do |base_category|
    context "#{base_category} base" do
      ['ichidan', 'godan', 'irregular'].each do |verb_category|
        BASES[verb_category].each do |word, bases|
          it "knows the #{base_category} base of #{word} (#{verb_category})" do
            verb = Katsuyoujin::Verb.new word
            base = Katsuyoujin::Base.new(verb, base_category).conjugate
            expect(bases[base_category]).to eq(base)
          end
        end
      end
    end
  end
end
