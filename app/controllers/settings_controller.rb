class SettingsController < ApplicationController
  before_action :authenticate_user!

  def account
    return render if request.get?

    current_user.name = params[:name] if params[:name].present?
    current_user.email = params[:email] if params[:email].present?
    current_user.save

    redirect_to settings_account_path
  end
end
