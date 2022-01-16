class Users::InterviewsController < AuthorizedController
  # GET /users/:user_id/interviews/1
  def show
    @user = User.find(params[:user_id])
    authenticate_friend! @user
    @interview = @user.interviews.find(params[:id])
  end
end
