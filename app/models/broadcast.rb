require 'watir-webdriver'
require 'bitcoin-client'

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

  # The address has sufficient balance to open/close:
  scope :funded, lambda{ where( 'is_funded = ?', true) }

  # Open Broadcast is sent:
  scope :opened, lambda{ where( 'is_opened = ?', true) }

  # Close Broadcast is sent:
  scope :closed, lambda{ where( 'is_closed = ?', true) }

  # These are in the queue and ready to close:
  scope :upcoming, lambda{ |now| funded.opened.where('closes_at >= ?', now) }

  # These have succesfully completed
  scope :expired, lambda{ |now| funded.closed.where('closes_at <= ?', now) }

  before_validation(on: :create){ generate_oracle_address }

  def short_label
    label[0...46]+'...'
  end

  def open_broadcast!
    # TODO: CP Broadcast
    self.btc_open_txid = 'TODO : From CP'
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
    self.btc_close_txid = 'TODO : From CP'
    self.is_closed = true
    self.closed_at = Time.now
    self.execution_screenshot = screen_tmp
    self.execution_title = browser.title

    # TODO : Cp Broadcast
    
    # Persist the model:
    self.save!

    ensure
      if screen_tmp
        screen_tmp.close
        screen_tmp.unlink
      end
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

  def generate_oracle_address
    bitcoin = Bitcoin::Client.new(BITCOIN_CONFIG['user'], BITCOIN_CONFIG['pass'], 
      :host => BITCOIN_CONFIG['host'], :port => BITCOIN_CONFIG['port'])
    self.btc_public_address = bitcoin.getnewaddress
  end
end
