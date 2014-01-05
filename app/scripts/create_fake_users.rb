#!/usr/bin/env /Users/tmoney/code/songs/bin/rails runner

n = ARGV[0].to_i
n.times do |i|
  user = User.new
  user.email = "fake-#{i}@example.com"
  user.password = 'cleopatra'
  user.status = 'NEW'
  user.name = "Fake #{i}"
  user.username = "afakeuser_#{i}"
  user.application = 'abc '*20
  user.save!
end
