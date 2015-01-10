# Expired Broadcasts:
Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,12,20,12,00,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,12,28,19,05,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,12,28,19,15,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets Win; 2=Miami Win;',
  :url => 'http://sports.yahoo.com/nfl/teams/mia/schedule/',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'NY Jets\')))")).has(".home .team:has(em:contains(\'Miami\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/\d+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
  ).save!

# TODO: Moar Broadcasts

# Upcoming Broadcasts:
Broadcast.new(
  :label => 'Dallas Cowboys At Green Bay Jan 11 @ 1:05 EST. 1=Dallas Win; 2=Greenbay Win;',
  :url => 'http://sports.yahoo.com/nfl/teams/dal/schedule/',
  :creator => 'lil_douchlet',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Detroit\')))")).has(".home .team:has(em:contains(\'Dallas\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/\d+/g);
    dallas_score = parseInt(scores[0]);
    greenbay_score = parseInt(scores[1]);

    if (dallas_score > greenbay_score) { return 1; }
    else if (dallas_score < greenbay_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
  ).save!

Broadcast.new(
  :label => 'Indianapolis At Denver Jan 11 @ 4:40 EST. 1=Indianapolis Win; 2=Denver;',
  :url => 'http://sports.yahoo.com/nfl/teams/ind/schedule/',
  :creator => 'lil_douchlet',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Indianapolis\')))")).has(".home .team:has(em:contains(\'Denver\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/\d+/g);
    indianapolis_score = parseInt(scores[0]);
    denver_score = parseInt(scores[1]);

    if (indianapolis_score > denver_score) { return 1; }
    else if (indianapolis_score < denver_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

# TODO: Do a miami property scrape

# TODO: Do a stock strape

# TODO: Do a forex price scrape
