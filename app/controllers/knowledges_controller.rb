class KnowledgesController < ApplicationController
  def index
    @words = current_user.words.with_knowledges.id_order.page(params[:page])
  end

  def destroy
    knowledge = Knowledge.find(params[:id])
    knowledge.destroy!
    redirect_to word_path(knowledge.word.id), success: t(:delete_success, scope: :flash)
  end
end
