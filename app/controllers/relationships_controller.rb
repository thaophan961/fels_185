class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    verify_user
    current_user.follow @user
    @count_followers = @user.followers.size
    responds
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    verify_user
    current_user.unfollow @user
    @count_followers = @user.followers.size
    responds
  end

  private
  def verify_user
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

  def responds
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
