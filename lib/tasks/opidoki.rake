namespace :opidoki do
  desc "These are tasks that need to run at a regular interval"
  task heartbeat: :environment do
    now = Time.now

    # Check for funding, and mark funding
    Broadcast.unfunded.each do |broadcast|
      broadcast.is_funded = true if broadcast.ask_bitcoin_if_funded?
      broadcast.save!
    end

    # Check for is_funded and open transaction
    Broadcast.requiring_open{ |broadcast| broadcast.open_broadcast! }

    # Check for closes_at and close transaction
    Broadcast.requiring_close(now){ |broadcast| broadcast.close_broadcast! }
  end

end
