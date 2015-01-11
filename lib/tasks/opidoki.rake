namespace :opidoki do
  desc "These are tasks that need to run at a regular interval"
  task heartbeat: :environment do
    while (true) do
      now = Time.now

      puts "Ping!"

      # Check for funding, and mark funding
      Broadcast.unfunded.each do |broadcast|
        begin
          puts broadcast.inspect
          broadcast.is_funded = true if broadcast.ask_bitcoin_if_funded?
          broadcast.save!
        rescue #RestClient::InternalServerError
          next
        end
      end

      # Check for is_funded and open transaction
      Broadcast.requiring_open.each do |broadcast| 
        puts "Open:"+broadcast.inspect
        begin
          broadcast.open_broadcast!
        rescue
          next
        end
      end

      # Check for closes_at and close transaction
      Broadcast.requiring_close(now).each do |broadcast| 
        begin
          puts "Close:"+broadcast.inspect
          broadcast.close_broadcast!
        rescue
          next
        end
      end

      sleep 1
    end
  end

end
