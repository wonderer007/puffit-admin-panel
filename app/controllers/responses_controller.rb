class ResponsesController < ApplicationController

  before_action :authenticate_user!

  def index
    @responses = current_user.responses
  end

end