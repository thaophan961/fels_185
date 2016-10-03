class FollowingController < ApplicationController
  before_action :logged_in_user
  before_action :load_users, only: :index

  def index
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
