puts 'Seeding Database...'

# Artists
puts 'Seeding 20 Artists...'
20.times do |index|
  puts "   Artist #{index + 1}"
  age = Random.rand(20..100)
  if [true, false].sample
    died = Random.rand(1920..2023)
    birth = died - age
  else
    birth = Random.rand(1930..2000)
  end
  artist = Artist.create(
    name: Faker::Name.name,
    born: birth,
    died: died,
    nationality: ISO3166::Country.codes.sample,
  )
  temp = Down.download(Faker::Avatar.image)
  artist.portrait.attach(io: temp, filename: 'cover.png')
end

# Stories
puts 'Seeding 200 Stories...'
200.times do |index|
  puts "   Story #{index + 1}"
  code = Faker::Code.unique.asin
  story = Story.create(
    code: code,
    url: "https://inducks.org/story.php?c=#{code}",
    published: Random.rand(1950..2023),
    origin: ISO3166::Country.codes.sample,
    pages: Random.rand(30..80),
    title: Faker::Movie.title,
    original_title: Faker::Movie.title,
  )
  temp = Down.download(Faker::LoremFlickr.image(size: '300x400', search_terms: ['comic']))
  story.cover.attach(io: temp, filename: 'cover.jpg')
end

# Roles
puts 'Connecting Artists and Stories through roles...'
Story.all.each do |story|
  roles = [*1..8].sample(3)
  3.times do |index|
    Role.create(
      story: story,
      artist: Artist.all.sample,
      task: roles[index]
    )
  end
end

# Books
puts 'Seeding 50 books...'
50.times do |index|
  puts "   Book #{index + 1}"
  book = Book.create(
    issue: index+1,
    title: Faker::DcComics.title,
    published: Random.rand(1950..2023),
    publication: Random.rand(0..9),
    pages: Random.rand(250..300),
    url: "https://inducks.org/issue.php?c=de%2FLTB+++#{index}",
  )
  temp = Down.download(Faker::LoremFlickr.image(size: '300x400', search_terms: ['comic']))
  book.cover.attach(io: temp, filename: 'cover.jpg')
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
