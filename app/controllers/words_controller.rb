class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @words = Word.where(user_id: current_user)
  end

  def new
    @word = current_user.words.build
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash[:success] = "単語登録が完了しました！"
      redirect_to @word
    else
      render "new"
    end
  end

  def show
    @word = Word.find(params[:id])
  end

  def edit
    @word = Word.find(params[:id])
    if @word.knowledges.size == 0
      3.times { @word.knowledges.build }
    else
      @word.knowledges.build
    end
  end

  def update
    @word = Word.find(params[:id])
    if @word.update_attributes(word_params)
      flash[:success] = "編集が完了しました！"
      redirect_to @word
    else
      render "edit"
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "単語を削除しました。"
    redirect_to words_url
  end

  private
    def word_params
      params.require(:word).permit(:content,
      knowledges_attributes: [:id, :url, :_destroy])
    end
end
