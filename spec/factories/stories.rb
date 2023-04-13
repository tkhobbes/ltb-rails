FactoryBot.define do
  factory :story do
    code { 'I TL  303-AP' }
    url { 'https://inducks.org/story.php?c=I+TL++303-AP' }
    published { 1961 }
    origin { 'Italy' }
    pages { 63 }
  end
end
