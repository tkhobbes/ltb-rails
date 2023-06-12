FactoryBot.define do
  factory :story do
    title { 'Paperino e il mistero del vecchio castello' }
    code { 'I TL  303-AP' }
    url { 'https://inducks.org/story.php?c=I+TL++303-AP' }
    published { 1961 }
    origin { 'IT' }
    pages { 63 }
  end
end
