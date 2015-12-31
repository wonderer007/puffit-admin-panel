class DeliveryReportsDatatable

  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view, campaign)
    @view = view
    @campaign = campaign
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @campaign.delivery_reports.count,
      iTotalDisplayRecords: delivery_reports.total_entries,
      aaData: data
    }
  end

  private

    def data
      delivery_reports.map do |delivery_report|

        if delivery_report.status
          status = "<span class='label label-success'>Sent</span>"
        else
          status = "<span class='label label-danger'>Pending</span>"
        end

        [
          delivery_report.phone_number,
          delivery_report.created_at.strftime("%e %b %Y %H:%M:%S%p").to_s,
          status
        ]
      end
    end

    def delivery_reports
      @delivery_reports ||= fetch_delivery_reports
    end

    def fetch_delivery_reports
      delivery_reports = @campaign.delivery_reports.order("#{sort_column} #{sort_direction}")
      delivery_reports = delivery_reports.page(page).per_page(per_page)
      if params[:sSearch].present?
        delivery_reports = delivery_reports.where("phone_number like :search", search: "%#{params[:sSearch]}%")
      end
      delivery_reports
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[id name created_at end_time status status]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] = "desc"
    end

end