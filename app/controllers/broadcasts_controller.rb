class BroadcastsController < ApplicationController
  def index
    now = Time.now

    @broadcast = Broadcast.new
    @upcoming = Broadcast.upcoming(now).order('closes_at DESC')
    @expired = Broadcast.expired(now).order('closes_at DESC')
  end

  def list_upcoming
    @upcoming = Broadcast.upcoming(Time.now).order('closes_at DESC')
  end

  def list_expired
    @expired = Broadcast.expired(Time.now).order('closes_at DESC')
  end

  def create
    #TODO: finish closes_at with time zones
    begin
      broadcast = Broadcast.new broadcast_params

=begin
      broadcast.match_type = 0
      
      # Huh?
      closes_at_params = {
        time: params["closes_at(time)"],
        zone: params["closes_at(zone)"]
      }

      #TODO: Remove this...
      broadcast.btc_public_address = 'mh6SNGA3HtusbeysegUFDQxBAJiRNBuopZ'

=end

      broadcast.closes_at_from_params! params[:closes_at]

      # It's sloppy, but it's also 5:00 A
      broadcast.match_type = (!broadcast.match_javascript.empty?) ? 
        Broadcast::MATCH_TYPE_JAVASCRIPT : Broadcast::MATCH_TYPE_REGEX

      broadcast.save!

      render :json => {
        broadcast: broadcast,
        amount: "0.0015", # in BTC $1 USD
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
