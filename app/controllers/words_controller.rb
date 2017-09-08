class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = current_user.words.without_knowledges.id_order.page(params[:page])
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      redirect_to root_url, success: t(:registration_success, scope: :flash)
    else
      @words = current_user.words.without_knowledges.id_order.limit(10)
      render "home/index"
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
      redirect_to @word, success: t(:update_success, scope: :flash)
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy!
    redirect_to root_url, success: t(:delete_success, scope: :flash)
  end

  private

    def word_params
      params.require(:word).permit(:content, knowledges_attributes: [:id, :url, :understanding])
    end

    def set_word
      @word = current_user.words.find(params[:id])
    end
end
