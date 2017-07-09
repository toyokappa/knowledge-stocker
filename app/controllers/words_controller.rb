class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show]

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

  private
    def word_params
      params.require(:word).permit(:content)
    end
end
