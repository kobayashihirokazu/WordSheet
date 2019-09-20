class LikesController < ApplicationController
    # skip_before_action :login_required
    before_action :set_word_id, only: [:create, :destroy]
    before_action :check_self_like

    def new
    end
  
    def create
        @like = Like.new(user_id: current_user.id, word_id: @word_id)

        if @like.save
          redirect_to word_path(@word_id), notice: "いいねしました。"
        else
          redirect_to word_path(@word_id), notice: "いいねできませんでした。"
        end
    end

    def destroy
        @like = Like.find_by(user_id: current_user.id, word_id: @word_id)
        @like.destroy
        redirect_to word_path(@word_id), notice: "いいねを取り消しました。"
    end

    private

    def set_word_id
        @word_id = params[:word_id]
    end

    def check_self_like
      @word = Word.find(@word_id)
      if current_user.id  == @word.user_id
        redirect_to login_path
      end
    end

  end