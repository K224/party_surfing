#coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!(email: 'lol@lol.lol', password: 'lolkalolka', password_confirmation: 'lolkalolka')
user.create_profile(name: 'lolka', surname: 'lolkin', photo: nil,
                   birthday: Date.new(1993,2,24), contacts: '1234')
user = User.create!(email: 'ara@ara.ara', password: 'araaraara', password_confirmation: 'araaraara')
user.create_profile(name: 'ara', surname: 'arara', photo: nil,
                   birthday: Date.new(1980,5,4), contacts: '8 916 123 45 67')
type = Type.create!(title: 'Вписка', description: 'Просто вписка')

user.parties.create(title: 'Праздник', summary: 'Все на вписку',
                    date: Date.today + 30, coord_latitude: 55.6457,
                    coord_longitude: 37.67682, type: type);

if AdminUser.find_by(id: 1).nil?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
