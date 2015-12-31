class ResponsesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_response, :only => [:show]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ResponsesDatatable.new(view_context, current_user) }
    end
  end

  def show
  end

  private

    def set_response
      @response = Response.find params[:id]
    end

end