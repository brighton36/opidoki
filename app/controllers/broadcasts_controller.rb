class BroadcastsController < ApplicationController
  def index
    @broadcast = Broadcast.new
    @upcoming = Broadcast.all
    @expired = Broadcast.all
  end

  #TODO Use scopes.
  def list_upcoming
    @upcoming = Broadcast.all
  end

  #TODO Use scopes.
  def list_expired
    @expired = Broadcast.all
  end

  def create
    #TODO: finish closes_at with time zones
    begin
      broadcast = Broadcast.new(broadcast_params)
      broadcast.match_type = 0
      
      closes_at_params = {
        time: params["closes_at(time)"],
        zone: params["closes_at(zone)"]
      }

      broadcast.closes_at_from_params! closes_at_params

      #TODO: Remove this...
      broadcast.btc_public_address = 'mh6SNGA3HtusbeysegUFDQxBAJiRNBuopZ'

      broadcast.match_type = 1 if !broadcast.match_regex.empty? && broadcast.match_javascript.empty?
      broadcast.match_type = 2 if !broadcast.match_javascript.empty? && broadcast.match_regex.empty?

      broadcast.save!

      render :json => {
        broadcast: broadcast,
        amount: "0.0036", # in BTC $1 USD
        label: 'opidoki'
      }, status: 200
    rescue ActiveRecord::RecordInvalid => invalid
      render :json => {
        errors: invalid.record.errors.full_messages.as_json
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
    params.require(:broadcast).permit(:include_jquery, :label, :closes_at, :creator, :btc_public_address, :match_type, :url, :match_javascript, :match_regex, :include_jquer, :is_funded)
  end
end
