class RelationshipsController < ApplicationController
    before_action :check_self_follow
    
    def create
      following = current_user.relationships.build(follow_id: params[:user_id])
      user = User.find_by(id: params[:show_user_id])
      if following.save
        redirect_to user, notice: 'ユーザーをフォローしました'
      else
        redirect_to user, alert: 'ユーザーのフォローに失敗しました'
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

    private
    def check_self_follow
      if current_user.id  == params[:user_id]
        redirect_to login_path
      end
    end

end
