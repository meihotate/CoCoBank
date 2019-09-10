# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(name: 'mei', email: 'm.h0tate@gmail.com', password: 'password')

User.create!(
  [
    {
      email: 'test1@test.com',
      password: '111111',
      name: 'カウンセラー太郎',
      sex: 0,
      location: 1,
      approved: 1,
    },
    {
      email: 'test2@test.com',
      password: '222222',
      name: 'カウンセラー花子',
      sex: 1,
      location: 2,
      approved: 1,
    },
    {
      email: 'test3@test.com',
      password: '333333',
      name: 'カウンセラー佳子',
      sex: 1,
      location: 3,
      approved: 1,
    },
    {
      email: 'test4@test.com',
      password: '444444',
      name: '生徒太郎',
      sex: 0,
      location: 4,
      approved: 0,
    },
    {
      email: 'test5@test.com',
      password: '555555',
      name: '生徒花子',
      sex: 1,
      location: 5,
      approved: 0,
    },
    {
      email: 'test6@test.com',
      password: '666666',
      name: '生徒佳子',
      sex: 1,
      location: 6,
      approved: 0,
    }
  ]
)