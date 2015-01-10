class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
  end
end
