class BooksController < ApplicationController
  before_action :set_book, :only => [:show, :edit, :update, :destroy]

  def index
    @books = Book.page params[:page]
  end

  def show
    @book_review = @book.reviews.build
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book Created Successfully"
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book Updated Successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy!
    flash[:notice] = "Book Deleted Successfully"
    redirect_to books_path
  end

private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :category_id, :picture, :description, :author, :instructions, :year, :pages)
  end

end
