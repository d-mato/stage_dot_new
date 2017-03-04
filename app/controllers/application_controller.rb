class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :sign_in_for_dev, if: -> { Rails.env.development? && params[:sign_in_user_id] }

  private

  # 開発環境用の自動ログイン機能
  def sign_in_for_dev
    sign_in User.find(params[:sign_in_user_id])
  end
end
