RSpec.shared_examples 'conjugations' do |collection|
  CONJUGATION_TYPES.each do |category|
    context category do
      context 'casual' do
        context 'affirmative' do
          collection.each do |verb, conjugations|
            it "knows the #{category} casual affirmative conjugation of #{verb}" do
              conj = Katsuyoujin.conjugate(verb, 'casual', category, 'affirmative')
              expect(conj).to eq conjugations['casual'][category]['affirmative']
            end
          end
        end
        context 'negative' do
          collection.each do |verb, conjugations|
            it "knows the #{category} casual negative conjugation of #{verb}" do
              conj = Katsuyoujin.conjugate(verb, 'casual', category, 'negative')
              expect(conj).to eq conjugations['casual'][category]['negative']
            end
          end
        end
      end

      context 'polite' do
        context 'affirmative' do
          collection.each do |verb, conjugations|
            it "knows the #{category} polite affirmative conjugation of #{verb}" do
              conj = Katsuyoujin.conjugate(verb, 'polite', category, 'affirmative')
              expect(conj).to eq conjugations['polite'][category]['affirmative']
            end
          end
        end
        context 'negative' do
          collection.each do |verb, conjugations|
            it "knows the #{category} polite negative conjugation of #{verb}" do
              conj = Katsuyoujin.conjugate(verb, 'polite', category, 'negative')
              expect(conj).to eq conjugations['polite'][category]['negative']
            end
          end
        end
      end
    end
  end
end
