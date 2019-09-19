class RelationshipsController < ApplicationController

    def create
      following = current_user.relationships.build(follow_id: params[:user_id])
      user = User.find_by(id: params[:show_user_id])
      if following.save
        redirect_to user, notice: 'ユーザーをフォローしました'
      else
        redirect_to user, alert: 'ユーザーをフォローに失敗しました'
      end
    end
  
    def destroy
      following = current_user.relationships.find_by(follow_id: params[:user_id])
      user = User.find_by(id: params[:show_user_id])
      if following.destroy
        redirect_to user, notice: 'ユーザーのフォローを解除しました'
      else
        redirect_to user, alert: 'ユーザーのフォロー解除に失敗しました'
      end
    end
end
