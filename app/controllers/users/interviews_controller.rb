class Users::InterviewsController < ApplicationController
  before_action :authenticate_user!

  # GET /users/:user_id/interviews/1
  def show
    @user = User.find(params[:user_id])
    authenticate_friend! @user
    @interview = Interview.find(params[:id])
  end
end
