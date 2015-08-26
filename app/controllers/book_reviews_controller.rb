class BookReviewsController < ApplicationController
  before_action :set_book

  def create
    @book_review = @book.reviews.build(book_review_params)
    @book_review.user_id = current_user.id
    @saved = @book_review.save
    respond_to(:js)
  end

private
  def set_book
    @book = Book.find(params[:book_id])
  end

  def book_review_params
    params.require(:book_review).permit(:rating, :description)
  end
end