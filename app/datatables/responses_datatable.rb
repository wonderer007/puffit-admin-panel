class ResponsesDatatable

  delegate :params, :link_to, :truncate, :number_to_currency, to: :@view

  def initialize(view,user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @user.responses.count,
      iTotalDisplayRecords: responses.total_entries,
      aaData: data
    }
  end

  private

    def data
      responses.map do |response|

        [
          response.phone_number,
          truncate(response.message, length: 50),
          response.created_at.strftime("%e %b %Y %H:%M:%S%p").to_s,
          link_to("<i class='fa fa-eye'></i>".html_safe, response)
        ]
      end
    end

    def responses
      @responses ||= fetch_responses
    end

    def fetch_responses
      responses = @user.responses.order("#{sort_column} #{sort_direction}")
      responses = responses.page(page).per_page(per_page)
      if params[:sSearch].present?
        responses = responses.where("phone_number like :search or message like :search", search: "%#{params[:sSearch]}%")
      end
      responses
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[phone_number message created_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end

end