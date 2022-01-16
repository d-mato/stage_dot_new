class HomeController < AuthorizedController
  def index
    @companies = current_user.companies

    @scheduled_inteviews = current_user.interviews.scheduled.order(start_at: :asc)
  end
end
