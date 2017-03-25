class FeedsController < ApplicationController
  before_action :authenticate_user!
  def index
    users = current_user.friends + [current_user]
    @feeds = Version.of_users(users).order(created_at: :desc)
  end
end
