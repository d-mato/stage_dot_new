class Users::CompaniesController < ApplicationController
  before_action :authenticate_user!

  # GET /users/:user_id/companies/1
  def show
    @user = User.find(params[:user_id])
    @company = Company.find(params[:id])
  end
end
