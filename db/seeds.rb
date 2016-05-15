# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create(title: 'New')
Category.create(title: 'Life')
Category.create(title: 'Sports')
Category.create(title: 'Technology')
Category.create(title: 'Programming')
Category.create(title: 'Ruby')
Category.create(title: 'HTML/CSS')
Category.create(title: 'Javascript')
Category.create(title: 'Food')
Category.create(title: 'Travel')

30.times do
  Tag.create(name: Faker::Hipster.word)
end
