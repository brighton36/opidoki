require "rails_helper"

RSpec.describe Broadcast do
  def expired_jets_game
    Broadcast.new(
      :label => 'NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets Win; 2=Miami Win;',

       # Entered into the system at 12/20 at Noon:
      :opened_at => DateTime.new(2014,12,20,12,00,00,'-5'),

      # User says to close 6 hours after the game:
      :closes_at => DateTime.new(2014,12,28,19,05,00,'-5'),

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
  end
  
  context "defaults" do 
    subject{ Broadcast.new }
    its(:match_type){ should eq(Broadcast::MATCH_TYPE_JAVASCRIPT) }
    its(:include_jquery){ should eq(true) }
    its(:is_opened){ should eq(false) }
    its(:is_closed){ should eq(false) }
    its(:is_funded){ should eq(false) }
  end

  context "set zone from params" do 
    subject do
      broadcast = Broadcast.new(
        {"label"=>"Testing", "url"=>"", "match_javascript"=>"", 
         "match_regex"=>"", "include_jquery"=>"1"})
      broadcast.closes_at_from_params!( HashWithIndifferentAccess.new({"time"=>"2015-01-15 14:30", "zone"=>"-18000"}) )
      broadcast
    end

    its(:closes_at){should eq(DateTime.new(2015,1,15,19,30,00,'0'))}
  end

  context ".initialize" do
    before(:all) { @broadcast = expired_jets_game }
    subject{ @broadcast }

    # Initialzed Fields:
    its(:label) { should eq('NY Jets At Miami Dec 28 @ 1:05 EST. 1=Ny Jets Win; 2=Miami Win;') }
    its(:is_opened) { should eq(true) }
    its(:is_closed) { should eq(true) }
    its(:is_funded) { should eq(true) }
    its(:url) { should eq('http://sports.yahoo.com/nfl/teams/mia/schedule/') }
    its(:creator) { should eq('fatso') }
    its(:match_type) { should eq(Broadcast::MATCH_TYPE_JAVASCRIPT) }
    its(:include_jquery ) { should eq(true) }
    its(:match_javascript ) { should be_a_kind_of String }
    its(:match_regex ) { should be_nil }
    its(:closes_at) { should be_a_kind_of Time }
    its(:creator) { should eq('fatso') }
  end


  # Open Broadcast Fields:
  context ".open_broadcast!" do
    before(:all) { @broadcast = expired_jets_game.tap{|b| b.open_broadcast! } }
    subject{ @broadcast }

    its(:opened_at) { should be_a_kind_of Time }
    its(:btc_public_address) { should be_a_kind_of String }
    its(:btc_open_txid) { should be_a_kind_of String }

    its(:persisted?) { should eq(true) }
  end

  # Open Broadcast Fields:
  context ".close_broadcast!" do
    before(:all) do
      @broadcast = expired_jets_game.tap{|b| 
        b.open_broadcast!
        b.close_broadcast!
      }
    end
    subject{ @broadcast }

    its(:closed_at) { should be_a_kind_of Time }

    # Close Broadcast Fields:
    its(:btc_close_txid) { should be_a_kind_of String }
    its(:closed_at) { should be_a_kind_of Time }

    # Jets (the away/visitor team) Won:
    its(:execution_return) { should eq(1) }
    its(:execution_title) { should eq('Miami Dolphins on Yahoo! Sports - News, Scores, Standings, Rumors, Fantasy Games') }

    its(:execution_screenshot_file_name) { should be_a_kind_of(String) }
    its(:execution_screenshot_file_size) { should be > 0 }
    its(:execution_screenshot_content_type) { should eq('image/png') }
    its(:execution_screenshot_updated_at) { should_not be_nil }

    its(:persisted?) { should eq(true) }
  end
end

