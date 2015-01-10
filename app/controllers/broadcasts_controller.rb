class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
    @upcoming = Broadcast.all
    @expired = Broadcast.all
  end

  def create
    begin
      @broadcast = Broadcast.new(broadcast_params).save!
      logger.info @broadcast.inspect

      render :json => {
        address: 'mh6SNGA3HtusbeysegUFDQxBAJiRNBuopZ', #@broadcast.btc_broadcast_address.to_json,
        amount: "0.0036", # in BTC $1 USD
        label: 'opidoki'
      }, status: 200
    rescue ActiveRecord::RecordInvalid => invalid
        render :json => {
          errors: invalid.record.errors.to_json
        }, status: 422
    end
      #TODO: rescue 500 response
#    rescue 500
  end

  def show
  end

  private

  def broadcast_params 
    params.require(:broadcast).permit(:label, :closes_at, :creator, :btc_public_address, :match_type, :url, :match_javascript, :match_regex, :include_jquery)
  end
end
