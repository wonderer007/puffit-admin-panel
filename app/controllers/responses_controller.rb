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
    @responses = Response.order(id: :desc).where(:phone_number => @response.phone_number).limit(10)
  end

  private

    def set_response
      @response = Response.find params[:id]
    end

end