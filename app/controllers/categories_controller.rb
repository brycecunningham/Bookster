class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @category
    @books = @category.books.page params[:page]
  end


end
