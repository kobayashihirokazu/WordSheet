class RelationshipsController < ApplicationController
    before_action :set_user

    def create
      @user = User.find(params[:relationship][:follow_id])
      following = current_user.follow(@user)
      if following.save
        redirect_to @user, notice: 'ユーザーをフォローしました'
      else
        redirect_to @user, alert: 'ユーザーをフォローに失敗しました'
      end
    end
  
    def destroy
      @user = User.find(params[:relationship][:follow_id])
      following = current_user.unfollow(@user)
      if following.destroy
        redirect_to @user, notice: 'ユーザーのフォローを解除しました'
      else
        redirect_to @user, alert: 'ユーザーのフォロー解除に失敗しました'
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:relationship][:follow_id])
    end
end
