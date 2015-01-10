# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Broadcast.new(
  :label => 'Dallas Cowboys At Green Bay Jan 11 @ 1:05',
  :url => 'http://sports.yahoo.com/nfl/teams/dal/schedule/',
  :creator => 'lil_douchlet',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => <<eos
score = $($(".game:has(.away .team:has(em:contains('Detroit')))")).has(".home .team:has(em:contains('Dallas'))").find('.score').text().trim();

eos ).save!

# TODO: Do a miami property scrape

# TODO: Do a stock strape

# TODO: Do a forex price scrape
