class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def index
    # @words = current_user.words.recent
    # @words = current_user.words <==>  Word.where(user_id: current_user.id)
    @q = current_user.words.ransack(params[:q])
    @words = @q.result(distinct: true).page(params[:page])
  end

  def show
  end

  def top
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = current_user.words.new(word_params)

    if @word.save
      redirect_to @word, notice: "タスク「#{@word.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @word.update(word_params)
      redirect_to words_url, notice: "タスク「#{@word.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @word.destroy
    redirect_to words_url, notice: "タスク「#{@word.name}」を削除しました。"
  end

  private

  def word_params
    params.require(:word).permit(:name, :description)
  end

  def set_word
    @word = current_user.words.find(params[:id])
    # @word = Word.find(params[:id])
  end
end
