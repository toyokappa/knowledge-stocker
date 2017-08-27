class HomeController < ApplicationController
  def index
    @word = current_user.words.build
    @words = current_user.words.id_order.limit(10)
  end
end
