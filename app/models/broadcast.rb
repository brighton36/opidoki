class Broadcast < ActiveRecord::Base
  validates :label, :closes_at, presence: true

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
end
