class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
    @upcoming = Broadcast.all
    @expired = Broadcast.all
  end

  def create
    #TODO: finish closes_at with time zones
    begin

      #NOTE: Remove this
      @broadcast = Broadcast.new(broadcast_params)
      @broadcast.btc_public_address = 'mh6SNGA3HtusbeysegUFDQxBAJiRNBuopZ'
      @broadcast.save!

      render :json => {
        broadcast:  @broadcast,
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
    @broadcast = Broadcast.find_by_id params[:id]

    respond_to do |format|
      format.html
      format.json {
        render :json => {
          broadcast: @broadcast.is_funded.to_json
        }
      }
    end
  end

  private

  def broadcast_params 
    params.require(:broadcast).permit(:label, :closes_at, :creator, :btc_public_address, :match_type, :url, :match_javascript, :match_regex, :include_jquer, :is_funded)
  end
end
