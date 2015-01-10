require 'watir-webdriver'

class Broadcast < ActiveRecord::Base
  # NOTE: We should probably be using an enum here, but it's a hackathon
  MATCH_TYPE_REGEX = 1
  MATCH_TYPE_JAVASCRIPT = 2

  INCLUDE_JQUERY_SCRIPT = <<eos
// Init Jquery:
var jq = document.createElement('script');
jq.src = "https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js";
document.getElementsByTagName('head')[0].appendChild(jq);
$.noConflict();
eos

  has_attached_file :execution_screenshot, 
    :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
    :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :execution_screenshot, 
    :content_type => /\Aimage\/.*\Z/

  # TODO : validate_required fields

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

  def short_label
    label[0...46]+'...'
  end

  def open_broadcast!
    # TODO: 
  end

  # Runs the browser, Executes truth, records into the blockchain, marks closed
  # saves
  def close_broadcast!
    browser = Watir::Browser.new :phantomjs
    browser.goto url

    screen_tmp = Tempfile.new('opiscreen')
    screen_tmp.close

    browser.screenshot.save screen_tmp.path
    screen_tmp.open

    execution_screenshot = screen_tmp
    browser_execution_title = browser.title
    is_closed = true

    # TODO : Cp Broadcast

    if match_type == MATCH_TYPE_JAVASCRIPT
      browser_return = browser.execute_script match_javascript
    elsif match_type == MATCH_TYPE_REGEX
      nil
      # TODO:
    end

    # todo: Save!

  end
end
