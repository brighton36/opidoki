# Grr - having dependency problems, so I rolled my own:
class GhettoBitcoinClient
  class GhettoBitcoinError < StandardError; end

  def initialize(options)
    @user, @pass, @host, @port = options['user'], options['pass'], 
      options['host'], options['port']
  end

  def getreceivedbyaddress(addr, confirmations)
    request 'getreceivedbyaddress', addr, confirmations
  end

  def getnewaddress
    request 'getnewaddress'
  end

  def connection_url
    'http://%s:%s@%s:%s' % [@user, @pass, @host, @port]
  end

  private 

  def request(method, *params)
    client = RestClient::Resource.new connection_url, :timeout => nil

    request = { method: method, params: params, id: 'jsonrpc' }.to_json

    response = JSON.parse client.post(request, accept: 'json', content_type: 'json')

    raise GhettoBitcoinError if response['error']

    response['result']
  end
end
