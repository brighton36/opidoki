require 'watir-webdriver'
require Rails.root.join('lib/ghetto_bitcoin_client')

class Broadcast < ActiveRecord::Base
  BITCOIN_CONFIG = YAML.load File.open(Rails.root.join('config','bitcoind.yml'))


  # NOTE: We should probably be using an enum here, but it's a hackathon
  MATCH_TYPE_REGEX = 1
  MATCH_TYPE_JAVASCRIPT = 2

  INCLUDE_JQUERY_SCRIPT = <<eos
var jq = document.createElement('script');
jq.src = "https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js";
document.getElementsByTagName('head')[0].appendChild(jq);
eos

  has_attached_file :execution_screenshot, 
    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
    :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :execution_screenshot, 
    :content_type => /\Aimage\/.*\Z/

  validates :label, presence: true
  validates :closes_at, presence: true
  validates :url, presence: true
  validates :match_type, presence: true
  validates :match_type, presence: true
  validates :btc_public_address, presence: true

  # The address is awaiting funding
  scope :unfunded, lambda{ where( 'is_funded = ?', false) }

  # The address has sufficient balance to open/close:
  scope :funded, lambda{ where('is_funded = ?', true) }

  # Open Broadcast is sent:
  scope :unopened, lambda{ where('is_opened = ?', false) }

  # Open Broadcast is sent:
  scope :opened, lambda{ where( 'is_opened = ? AND is_closed = ?', true, false) }

  # Close Broadcast is sent:
  scope :closed, lambda{ where( 'is_opened = ? AND is_closed = ?', true, true) }

  # These are in the queue and ready to close:
  scope :upcoming, lambda{ |now| funded.opened.where('closes_at >= ?', now) }

  # These have succesfully completed
  scope :expired, lambda{ |now| funded.closed }

  # Needs to be processed
  scope :requiring_open, lambda{funded.unopened}

  # These are past the close_at, and are ready for closing
  scope :requiring_close, lambda{ |now| funded.opened.where('closes_at <= ?', now) }

  before_validation(on: :create){ generate_oracle_address }

  def short_label
    'http://www.opidoki.com/broadcasts/%s' % id
  end

  def open_broadcast!
    # Announce the availability of a Bet:

    # NOTE: All times are in UTC
    if Rails.env.test?
      self.btc_open_txid = "TODO: I'm lazy,and its a hackathon"
    else
      pubkey = bitcoin_client.validateaddress(self.btc_public_address)['pubkey']
      self.btc_open_txid = Counterparty::Broadcast.new( source: self.btc_public_address, 
        value: Counterparty::Broadcast::OPEN_BROADCAST, timestamp: Time.now.to_i,
        text: self.short_label, fee_fraction: 0.00, pubkey: pubkey, 
        allow_unconfirmed_inputs: true ).save!
    end
    self.is_opened = true

    self.save!
  end

  # Runs the browser, Executes truth, records into the blockchain, marks closed
  # saves
  def close_broadcast!
    # TODO: Raise an error if we're not opened?

    # Open the Browser:
    browser = Watir::Browser.new :phantomjs
    browser.goto url

    # Get the screenshot:
    screen_tmp = Tempfile.new(['opiscreen', '.png'])
    screen_tmp.close
    screen_tmp.open
    browser.screenshot.save screen_tmp.path

    # Mutate State:
    self.execution_return = execute_truther browser
    self.is_closed = true
    self.closed_at = Time.now
    self.execution_screenshot = screen_tmp
    self.execution_title = browser.title

    # Cp Broadcast
    if Rails.env.test?
      self.btc_close_txid  = "TODO: I'm lazy,and its a hackathon"
    else
      pubkey = bitcoin_client.validateaddress(self.btc_public_address)['pubkey']

      self.btc_close_txid = Counterparty::Broadcast.new( source: self.btc_public_address, 
        value: self.execution_return, timestamp: Time.now.to_i, 
        fee_fraction: 0.00, text: self.short_label, pubkey: pubkey,
        allow_unconfirmed_inputs: true ).save!
    end
    
    # Persist the model:
    self.save!

    ensure
      if screen_tmp
        screen_tmp.close
        screen_tmp.unlink
      end
  end

  def ask_bitcoin_if_funded?
    bitcoin_client.getreceivedbyaddress(self.btc_public_address, 0).try(:>, 0.001)
  end

  def closes_at_from_params!( params )
    self.closes_at = Time.zone.parse '%s %3.0f' % [params[:time], 
      params[:zone].to_f / 3600 * 100]
  end

  private

  def execute_truther(browser)
    if match_type == MATCH_TYPE_JAVASCRIPT
      browser.execute_script INCLUDE_JQUERY_SCRIPT if self.include_jquery
      sleep 1 # Yeah it's hacky, but this is a hackathon.
      
      browser.execute_script match_javascript
    elsif match_type == MATCH_TYPE_REGEX
      # TODO:
      nil
    end
  end

  def bitcoin_client
    GhettoBitcoinClient.new BITCOIN_CONFIG
  end

  def generate_oracle_address
    self.btc_public_address = bitcoin_client.getnewaddress
  end
end
