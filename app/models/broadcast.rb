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

end
