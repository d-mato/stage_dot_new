class Users::CompaniesController < AuthorizedController
  # GET /users/:user_id/companies/1
  def show
    @user = User.find(params[:user_id])
    authenticate_friend! @user
    @company = @user.companies.find(params[:id])
  end
end
