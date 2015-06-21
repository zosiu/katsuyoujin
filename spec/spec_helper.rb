require 'katsuyoujin'

BASE_CATEGORIES = ['あ', 'い', 'う', 'え', 'お', 'て', 'た']
ICHIDAN_BASES = YAML.load_file('spec/fixtures/ichidan/base.yml')

BASES = { 'ichidan' => YAML.load_file('spec/fixtures/ichidan/base.yml'),
          'godan' => YAML.load_file('spec/fixtures/godan/base.yml') }

CONJUGATIONS = YAML.load_file('spec/fixtures/conjugations.yml')
