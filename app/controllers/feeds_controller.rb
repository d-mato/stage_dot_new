class FeedsController < ApplicationController
  before_action :authenticate_user!
  def index
    users = current_user.friends.pluck(:id) + [current_user]
    @feeds = Version.of_users(users)
  end
end
