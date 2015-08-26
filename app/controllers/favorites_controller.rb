class FavoritesController < ApplicationController
  before_action :require_login
  def create
    book = Book.find(params[:book_id])
    raise ActiveRecord::RecordNotFound unless book
    current_user.favorite_books << book
    head :ok
  end

  def destroy
    book = Book.find(params[:book_id])
    raise ActiveRecord::RecordNotFound unless book
    current_user.favorite_books -= [book]
    head :ok
  end
end
