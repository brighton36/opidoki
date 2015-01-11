# Expired Broadcasts:
=begin
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

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!
=end

Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,9,7,12,00,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,9,7,19,05,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,9,7,19,15,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'New England At Miami Sep 07 @ 1:05 EST. 1=New England Win; 2=Miami Win;',
  :url => 'http://sports.yahoo.com/nfl/teams/mia/schedule/',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'New England\')))")).has(".home .team:has(em:contains(\'Miami\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,9,14,12,00,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,9,14,19,05,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,9,14,19,15,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'Miami At Buffalo Sep 14 @ 1:05 EST. 1=Miami Win; 2=Buffalo Win;',
  :url => 'http://sports.yahoo.com/nfl/teams/mia/schedule/',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Miami\')))")).has(".home .team:has(em:contains(\'Buffalo\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,9,28,16,00,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,9,28,22,05,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,9,28,22,15,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'Kansas City At Miami Sep 14 @ 4:25 EST. 1=Kansas City Win; 2=Miami Win;',
  :url => 'http://sports.yahoo.com/nfl/teams/mia/schedule/',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Kansas City\')))")).has(".home .team:has(em:contains(\'Miami\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,10,29,19,30,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,10,29,23,30,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,10,29,23,35,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'Washington At Miami Heat Oct 29 @ 7:30 EST. 1=Washington Win; 2=Miami Win;',
  :url => 'http://sports.yahoo.com/nba/teams/mia/schedule',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'NY Jets\')))")).has(".home .team:has(em:contains(\'Miami\'))")[0]

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

Broadcast.new(
   # Entered into the system at 12/20 at Noon:
  :opened_at => DateTime.new(2014,11,01,19,00,00,'-5'),

  # User says to close 6 hours after the game:
  :closes_at => DateTime.new(2014,10,29,23,30,00,'-5'),
  
  # Actual close time was 10 minutes thereafter:
  :closed_at => DateTime.new(2014,10,29,23,35,00,'-5'),

  # Baller status:
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

  # Mark it complete:
  :is_opened => true,
  :is_closed => true,
  :is_funded => true,

  :label => 'Miami At Philadelphia Heat Nov 1 @ 7:00 EST. 1=Miami Win; 2=Philadelphia Win;',
  :url => 'http://sports.yahoo.com/nba/teams/mia/schedule',
  :creator => 'fatso',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Miami\')))")).has(".home .team:has(em:contains(\'Philadelphia\'))")[0]

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    visitor_score = parseInt(scores[0]);
    home_score = parseInt(scores[1]);

    if (visitor_score > home_score) { return 1; }
    else if (visitor_score_score < home_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

# Upcoming Broadcasts:
Broadcast.new(
  :label => 'Dallas Cowboys At Green Bay Jan 11 @ 1:05 EST. 1=Dallas Win; 2=Greenbay Win;',
  
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',
  # Mark it open:
  :is_opened => true,
  :is_funded => true,

  # Closes 6 hours after the start of the game:
  :closes_at => DateTime.new(2015,1,11,19,05,00,'-5'),

  :url => 'http://sports.yahoo.com/nfl/teams/dal/schedule/',
  :creator => 'lil_douchlet',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Detroit\')))")).has(".home .team:has(em:contains(\'Dallas\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    dallas_score = parseInt(scores[0]);
    greenbay_score = parseInt(scores[1]);

    if (dallas_score > greenbay_score) { return 1; }
    else if (dallas_score < greenbay_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
  ).save!

Broadcast.new(
  :label => 'Indianapolis At Denver Jan 11 @ 4:40 EST. 1=Indianapolis Win; 2=Denver;',
  
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',
  # Mark it open:
  :is_opened => true,
  :is_funded => true,

  # Closes 6 hours after the start of the game:
  :closes_at => DateTime.new(2015,1,11,22,40,00,'-5'),

  :url => 'http://sports.yahoo.com/nfl/teams/ind/schedule/',
  :creator => 'lil_douchlet',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    game_cell = $($(".game:has(.away .team:has(em:contains(\'Indianapolis\')))")).has(".home .team:has(em:contains(\'Denver\'))")

    scores = $(game_cell).find(\'.score\').text().trim().match(/[0-9]+/g);
    indianapolis_score = parseInt(scores[0]);
    denver_score = parseInt(scores[1]);

    if (indianapolis_score > denver_score) { return 1; }
    else if (indianapolis_score < denver_score) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

Broadcast.new(
  :label => 'Will the S&P go up by end of day Jan 12 @ 5:00 EST. 1=Yes; 2=No',
  
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',
  # Mark it open:
  :is_opened => true,
  :is_funded => true,

  # Closes 15 minutes after the S&P closes Monday
  :closes_at => DateTime.new(2015,1,12,17,15,00,'-5'),

  :url => 'http://finance.yahoo.com/q?s=^GSPC',
  :creator => 'bilbo_bagpipes',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    base_price = parseFloat("2044.81")
    price = $("#yfi_rt_quote_summary .time_rtq_ticker span").html()
    closing_price = parseFloat( price_el.replace(",","") )

    if (closing_price > base_price) { return 1; }
    else if (closing_price < base_price) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!

# http://bcpa.net/RecInfo.asp?URL_Folio=494235010040
Broadcast.new(
  :label => 'Has BCPA been Transfered the cderose Deed to Aamador on Jan 12? 1=Yes; 2=No',
  
  :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',
  # Mark it open:
  :is_opened => true,
  :is_funded => true,

  # Closes 15 minutes after the S&P closes Monday
  :closes_at => DateTime.new(2015,1,11,23,00,00,'-5'),

  :url => 'http://bcpa.net/RecInfo.asp?URL_Folio=494235010040',
  :creator => 'bilbo_bagpipes',
  :match_type => Broadcast::MATCH_TYPE_JAVASCRIPT,
  :include_jquery => true,
  :match_javascript => '
    current_owner = $($(".BodyCopyBold9")[1]).html().replace("<br>","").trim()
    cderose = "DEROSE,CHRISTOPHER LAWRENCE"
    aamador = "AMADOR,ARIAN ADOLFO"

    if (current_owner === aamador) { return 1; }
    else if (current_owner === cderose) { return 2; }
    // There was an error, or a tie. Unresolvable:
    else { return 0; }'
).save!
