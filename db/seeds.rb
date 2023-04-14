puts 'Seeding Database...'

# Artists
puts 'Seeding 20 Artists...'
20.times do
  age = Random.rand(20..100)
  if [true, false].sample
    died = Random.rand(1920..2023)
    birth = died - age
  else
    birth = Random.rand(1930..2000)
  end
  Artist.create(
    name: Faker::Name.name,
    born: birth,
    died: died,
    nationality: Faker::Address.country
  )
end

# Stories
puts 'Seeding 200 Stories...'
200.times do
  code = Faker::Code.unique.asin
  Story.create(
    code: code,
    url: "https://inducks.org/story.php?c=#{code}",
    published: Random.rand(1950..2023),
    origin: Faker::Address.country,
    pages: Random.rand(30..80),
    title: Faker::Movie.title,
    original_title: Faker::Movie.title
  )
end

# Roles
puts 'Connecting Artists and Stories through roles...'
Story.all.each do |story|
  3.times do |index|
    Role.create(
      story: story,
      artist: Artist.all.sample,
      task: index
    )
  end
end

# Books
puts 'Seeding 50 books...'
50.times do |index|
  Book.create(
    issue: index,
    title: Faker::DcComics.title,
    published: Random.rand(1950..2023),
    pages: Random.rand(250..300),
    url: "https://inducks.org/issue.php?c=de%2FLTB+++#{index}"
  )
end

# Book Entries
puts 'Connecting stories and books through book entries...'
Book.all.each do |book|
  stories = Story.all.sample(5)
  5.times do |index|
    BookEntry.create(
      book: book,
      story: stories[index]
    )
  end
end

# Users
puts 'Seeding 2 users...'
User.create(
  email: 'tkhobbes@example.com',
  password: 'password',
  name: 'tkhobbes',
  admin: true
)

User.create(
  email: 'jdoe@example.com',
  password: 'password',
  name: 'John Doe',
  admin: false
)

puts 'Seeding of database complete.'
