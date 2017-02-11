class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    render json: request.env['omniauth.auth']
  end

  def twitter
    render json: request.env['omniauth.auth']
  end
end
