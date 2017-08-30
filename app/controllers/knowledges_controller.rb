class KnowledgesController < ApplicationController
  def index
    @words = current_user.words.with_knowledges.id_order.page(params[:page])
  end
end
