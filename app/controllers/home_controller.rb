class HomeController < ApplicationController

  require 'net/http'
  before_action :authenticate_user!
  
  def index
  end

  def puffit
    result = Net::HTTP.get(URI.parse('http://212.100.239.153/koonj-api/api/roster.php?jid=hsy@212.100.239.153'))
    @followers = JSON.parse(result)
  end

end