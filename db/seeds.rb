#coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create!(email: 'lol@lol.lol', password: 'lolkalolka', password_confirmation: 'lolkalolka')
user.profile.update(name: 'lolka', surname: 'lolkin', photo: nil,
                   birthday: Date.new(1993,2,24), contacts: '1234')
type = Type.create!(title: 'Вписка', description: 'Просто вписка')

user.parties.create(title: 'Вписон', summary: 'Все на вписку',
                    date: Date.today + 30, coord_latitude: 0,
                    coord_longitude: 0, type: type);
