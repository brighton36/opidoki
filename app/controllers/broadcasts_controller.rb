class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
    @upcoming = Broadcast.all
    @expired = Broadcast.all
  end

  def create
    Broadcast.create(broadcast_params)
  end

  def update
    #strong_params
  end

  private

  def broadcast_params 
    params.require(:broadcast).permit(:label, :closes_at, :creator, :btc_public_address, :match_type, :url, :match_javascript, :match_regex, :include_jquery)
  end
end
