class HomeController < ApplicationController

  require 'net/http'
  before_action :authenticate_user!
  
  def index
  end

  def followers
    @followers = current_user.followers
  end

  def profile
    
  end

end