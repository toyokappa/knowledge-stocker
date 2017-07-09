class WordsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @word = current_user.words.build
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash[:success] = "単語登録が完了しました！"
      redirect_to root_url
    else
      render "new"
    end
  end

  private
    def word_params
      params.require(:word).permit(:content)
    end
end
