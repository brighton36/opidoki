class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
    @upcoming = Broadcast.all
    @expired = Broadcast.all
  end

  def create
    logger.info 'creating.....'
    begin
      @broadcast = Broadcast.new(broadcast_params).save!
      logger.info @broadcast.inspect

      render :json => {
        address: '18Vm8AvDr9Bkvij6UfVR7MerCyrz3KS3h4' #@broadcast.btc_broadcast_address.to_json,
      }, status: 200
    rescue ActiveRecord::RecordInvalid => invalid
        render :json => {
          errors: invalid.record.errors.to_json
        }, status: 422
    end
      #TODO: rescue 500 response
#    rescue 500
  end

  def update
    #strong_params
  end

  private

  def broadcast_params 
    params.require(:broadcast).permit(:label, :closes_at, :creator, :btc_public_address, :match_type, :url, :match_javascript, :match_regex, :include_jquery)
  end
end
