class WordsController < ApplicationController
  def index
    @words = current_user.words
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
    @word = current_user.words.find(params[:id])
    @knowledges = @word.knowledges.understanding_order
  end

  def edit
    @word = current_user.words.find(params[:id])
    if @word.knowledges.empty?
      3.times { @word.knowledges.build }
    else
      @word.knowledges.build
    end
  end

  def update
    @word = current_user.words.find(params[:id])
    if @word.update(word_params)
      flash[:success] = "編集が完了しました！"
      redirect_to @word
    else
      render "edit"
    end
  end

  def destroy
    @word = current_user.words.find(params[:id])
    @word.destroy
    flash[:success] = "単語を削除しました。"
    redirect_to words_url
  end

  private

  def word_params
    params.require(:word).permit(:content,
    knowledges_attributes: [:id, :url, :understanding, :_destroy])
  end
end
