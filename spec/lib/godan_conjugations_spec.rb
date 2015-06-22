GODAN_CONJUGATIONS.each do |ending, conjugations|
  describe "godan conjugations (#{ending} ending)" do
    it_should_behave_like 'conjugations', conjugations
  end
end
