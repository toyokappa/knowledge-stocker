class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = current_user.words.page(params[:page])
  end

  def new
    @word = current_user.words.build
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash[:success] = t(:registration_success, scope: :flash)
      redirect_to @word
    else
      render "new"
    end
  end

  def show
    @knowledges = @word.knowledges.understanding_order
  end

  def edit
    @word.knowledges.build
  end

  def update
    if @word.update(word_params)
      flash[:success] = t(:update_success, scope: :flash)
      redirect_to @word
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy!
    flash[:success] = t(:delete_success, scope: :flash)
    redirect_to words_url
  end

  private

    def word_params
      params.require(:word).permit(:content,
                                   knowledges_attributes: [:id, :url, :understanding, :_destroy])
    end

    def set_word
      @word = current_user.words.find(params[:id])
    end
end
