# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'

photos = ['db/seed_images/image1.png', 'db/seed_images/image2.png', 'db/seed_images/image3.png']

Company.destroy_all
Genre.destroy_all
Platform.destroy_all
Game.destroy_all
Critic.destroy_all
User.destroy_all

puts 'Start seeding Companies'
companies_data = JSON.parse(File.read('db/companies.json'), symbolize_names: true)
companies_data.each do |company_data|
  Company.create(company_data)
end
puts 'Finish seeding Companies'

puts 'Start seeding Genres'
genres_data = JSON.parse(File.read('db/genres.json'), symbolize_names: true)
genres_data.each do |genre|
  Genre.create(name: genre)
end
puts 'Finish seeding Genres'

puts 'Start seeding Platforms'
platforms_data = JSON.parse(File.read('db/platforms.json'), symbolize_names: true)
platforms_data.each do |platform_data|
  Platform.create(platform_data)
end
puts 'Finish seeding Platforms'

puts 'Start seeding Games and relationships'
games_data = JSON.parse(File.read('db/games.json'), symbolize_names: true)
games_data.each do |game_data|
  game = {
    name: game_data[:name],
    summary: game_data[:summary],
    release_date: game_data[:release_date],
    category: game_data[:category],
    rating: game_data[:rating],
    parent: Game.find_by(name: game_data[:parent])
  }

  new_game = Game.create(game)

  new_game.cover.attach(io: File.open(photos.sample), filename: "#{game[:name]}.jpg")

  game_data[:genres].each do |genre|
    new_game.genres << Genre.find_by(name: genre)
  end

  game_data[:platforms].each do |platform|
    new_game.platforms << Platform.find_by(name: platform[:name])
  end

  game_data[:involved_companies].each do |involved_company|
    new_game.involved_companies.create(
      developer: involved_company[:developer],
      publisher: involved_company[:publisher],
      company: Company.find_by(name: involved_company[:name])
    )
  end
end

puts 'Finish seeding Games and relationships'

puts 'Start seeding Users'
role_opt = ["carlos", "member"]
user = {
  email: "carlos@gmail.com",
  username: "carlos",
  role: "admin",
  password: "123456",
  password_confirmation: "123456"
}
User.create(user)

rand(1..4).times {
  user = {
    email: Faker::Internet.email,
    username: Faker::Games::LeagueOfLegends.champion, 
    role: role_opt.sample,
    password: "123456",
    password_confirmation: "123456"
  }
  User.create(user)
}
puts 'Finish seeding Users'

puts 'Start seeding Critics'
users = User.all
Game.all.each do |game|
  rand(1..3).times {
    critic = {
      title: Faker::Games::LeagueOfLegends.quote,
      body: Faker::Lorem.sentence(word_count: 10),
      user_id: users.sample.id
    }
    game.critics << Critic.new(critic)
    game.save
  }
end
puts 'Finish seeding Critics'
