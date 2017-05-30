# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create an admin user
admin = User.find_by_username('betgod') || User.create!(
  username: 'betgod',
  email: 'betgod@gmail.com',
  password: 'dificil',
  is_admin: true,
  email_confirmed: true,
  money: 100000)

# Create 2 test users
test_user1 = User.find_by_username('testuser1') || User.create!(
  username: 'testuser1',
  email: 'test@user.com',
  password: 'dificil',
  is_admin: false,
  money: 1000)

test_user2 = User.find_by_username('testuser2') || User.create!(
  username: 'testuser2',
  email: 'test2@user.com',
  password: 'dificil',
  is_admin: false,
  money: 1000)

# Create a friendship between them
Friendship.create(user: test_user1, friend: test_user2, confirmed: true)
Friendship.create(user: test_user2, friend: test_user1, confirmed: true)

# Create initial categories
politics_category = Category.find_or_create_by!(name: 'Politics')
sports_category = Category.find_or_create_by!(name: 'Sports')
awards_category = Category.find_or_create_by!(name: 'Awards')

# Create a Gee for USA Elections
usa_elections_gee = Gee.find_by_name('USA Elections') || Gee.create!(
  user: test_user1,
  name: 'USA Elections',
  description: 'Vote for your favorite president',
  category: politics_category,
  state: 'opened',
  is_public: true,
  expiration_date: '2017-12-01')

usa_elections_field1 = usa_elections_gee.fields.find_by_name('President') || usa_elections_gee.fields.create!(
  name: 'President',
  ttype: 'Alternatives',
  min_value: nil,
  max_value: nil)

usa_elections_field1.alternatives.create(value: 'Obama')
usa_elections_field1.alternatives.create(value: 'Trump')

# Create a Gee for Soccer with friends
soccer_friends_gee = Gee.find_by_name('Soccer with friends') || Gee.create!(
  user: test_user1,
  name: 'Soccer with friends',
  description: 'Which will be the result?',
  category: sports_category,
  state: 'opened',
  is_public: false,
  expiration_date: '2017-07-03')

soccer_friends_field1 = soccer_friends_gee.fields.find_by_name('Local') || soccer_friends_gee.fields.create!(
  name: 'Local',
  ttype: 'Number',
  min_value: 0,
  max_value: 30)

soccer_friends_field2 = soccer_friends_gee.fields.find_by_name('Visit') || soccer_friends_gee.fields.create!(
  name: 'Visit',
  ttype: 'Number',
  min_value: 0,
  max_value: 30)

# Create some bets
bet1 = usa_elections_gee.bets.find_or_create_by!(
  user: test_user1,
  quantity: 100)
bet1.values.create(
  field: usa_elections_field1,
  value: 'Obama')

bet2 = usa_elections_gee.bets.find_or_create_by!(
  user: test_user2,
  quantity: 200)
bet2.values.create(
  field: usa_elections_field1,
  value: 'Obama')
