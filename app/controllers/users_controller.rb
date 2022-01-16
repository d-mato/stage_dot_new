class UsersController < AuthorizedController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authenticate_friend! @user
  end
end
