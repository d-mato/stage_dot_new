class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_or_create_social_profile, only: [:github, :twitter]

  def github
    redirect_to root_path
  end

  def twitter
    redirect_to root_path
  end

  private

  def set_or_create_social_profile
    auth = request.env['omniauth.auth']
    profile = SocialProfile.find_or_initialize_by(provider: auth['provider'], uid: auth['uid'])

    profile.oauth_data = auth
    user = profile.user || User.create_with_social_profile!(profile)

    sign_in user
  end
end
