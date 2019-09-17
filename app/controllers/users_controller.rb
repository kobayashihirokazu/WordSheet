class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :likes, :followings, :followers]
  skip_before_action :login_required, only: [:new, :create, :show, :likes]

  def index
    @users = User.all
  end

  def show
    @q = Word.where(user_id: @user.id).ransack(params[:q])
    @words = @q.result(distinct: true).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザ「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "ユーザ「#{@user.name}」を削除しました。"
  end

  def likes
    @q = Like.where(user_id: @user.id).ransack(params[:q])
    @likes = @q.result(distinct: true).page(params[:page])
  end

  def followings
    @q = @user.followings.ransack(params[:q])
    @followings = @q.result(distinct: true).page(params[:page])
  end

  def followers
    @q = @user.followers.ransack(params[:q])
    @followers = @q.result(distinct: true).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
