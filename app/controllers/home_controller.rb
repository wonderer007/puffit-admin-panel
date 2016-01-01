class HomeController < ApplicationController

  before_action :authenticate_user!
  
  def index
  end

  def followers
    @followers = current_user.followers
  end

  def profile
  end

end