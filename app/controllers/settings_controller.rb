class SettingsController < AuthorizedController
  def account
    return render if request.get?

    current_user.name = params[:name] if params[:name].present?
    current_user.email = params[:email] if params[:email].present?

    return render unless current_user.save

    flash[:success] = 'Account was successfully updated.'
    redirect_to settings_account_path
  end
end
