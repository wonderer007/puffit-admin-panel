class CampaignsDatatable

  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Campaign.count,
      iTotalDisplayRecords: campaigns.total_entries,
      aaData: data
    }
  end

  private

    def data
      campaigns.map do |campaign|

        if campaign.status
          status = "<span class='label label-success'>Sent</span>"
        else
          status = "<span class='label label-danger'>Pending</span>"
        end

        end_time = campaign.end_time.nil? ? '-' : campaign.end_time.strftime("%e %b %Y %H:%M:%S%p").to_s

        [
          campaign.id,
          campaign.name,
          campaign.created_at.strftime("%e %b %Y %H:%M:%S%p").to_s,
          end_time,
          status,
          "<a href='/campaigns/#{campaign.id}'><i class='fa fa-eye'></i></a>  <a href='/campaigns/#{campaign.id}/delivery_report'><i class='fa fa-file'></i></a>".html_safe

        ]
      end
    end

    def campaigns
      @campaigns ||= fetch_campaigns
    end

    def fetch_campaigns
      campaigns = Campaign.order("#{sort_column} #{sort_direction}")
      campaigns = campaigns.page(page).per_page(per_page)
      if params[:sSearch].present?
        campaigns = campaigns.where("id like :search or name like :search or created_at like :search or end_time like :search", search: "%#{params[:sSearch]}%")
      end
      campaigns
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
      params[:sSortDir_0] == "desc" ? "desc" : "asc"

    end

end