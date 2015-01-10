require "rails_helper"

RSpec.describe Broadcast do
  let(:expired_jets_game) do 
    broadcast = Broadcast.new(
      :label => 'NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets Win; 2=Miami Win;',

       # Entered into the system at 12/20 at Noon:
      :opened_at => DateTime.new(2014,12,20,12,00,00,'-5'),

      # User says to close 6 hours after the game:
      :closes_at => DateTime.new(2014,12,28,19,05,00,'-5'),
      
      # Baller status:
      :btc_public_address => '1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs',

      # Mark it complete:
      :is_opened => true,
      :is_closed => true,
      :is_funded => true,

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
        else { return 0; }' )
    broadcast.open_broadcast!
    broadcast.close_broadcast!

    puts "TODO: Execution Screenie" + broadcast.execution_screenshot.inspect
    broadcast
  end

  context ".initialize" do
    subject{expired_jets_game}

    # Initialzed Fields:
    its(:label) { eq('NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets Win; 2=Miami Win;') }
    its(:is_opened) { eq(true) }
    its(:is_closed) { eq(true) }
    its(:is_funded) { eq(true) }
    its(:url) { eq('http://sports.yahoo.com/nfl/teams/mia/schedule/') }
    its(:creator) { eq('fatso') }
    its(:match_type) { eq(Broadcast::MATCH_TYPE_JAVASCRIPT) }
    its(:include_jquery ) { eq(true) }
    its(:match_javascript ) { be_a_kind_of String }
    its(:match_regex ) { be_a_kind_of String }
    its(:closed_at) { be_a_kind_of Time }
    its(:closes_at) { be_a_kind_of Time }
    its(:creator) { eq('Fatso') }

    # Calculated by init:
    its(:short_label) { eq('NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets ...') }
  end

  # Open Broadcast Fields:
  context ".open_broadcast!" do
    subject{ expired_jets_game.tap{|b| b.open_broadcast! } }

    its(:opened_at) { be_a_kind_of Time }
    its(:btc_public_address) { eq('1AeRVukQNG3qhd3i31pwFa7Z8qc6JnkYEs') }
    its(:btc_open_txid) { be_a_kind_of String }

    its(:persisted?) { be_true }
  end

  # Open Broadcast Fields:
  context ".close_broadcast!" do
    subject{
      broadcast = expired_jets_game
      broadcast.close_broadcast!
    }

    # Close Broadcast Fields:
    its(:btc_close_txid) { be_a_kind_of String }
    its(:closed_at) { be_a_kind_of Time }

    # Jets (the away/visitor team) Won:
    its(:execution_return) { 1 }
    its(:execution_title) { 'Miami Dolphins on Yahoo! Sports - News, Scores, Standings, Rumors, Fantasy Games' }

    # TODO:  
    #its('execution_screenshot'
    #it { should validate_attachment_presence(:avatar) }
    #it { should validate_attachment_content_type(:avatar).
    #allowing('image/png', 'image/gif').
    #rejecting('text/plain', 'text/xml') }
    #it { should validate_attachment_size(:avatar).
    #less_than(2.megabytes) }

    its(:persisted?) { be_true }
  end
end

