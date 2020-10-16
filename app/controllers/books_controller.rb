class BooksController < ApplicationController

  def create

  end

  def index

  end

  def show

  end

  private
  def book_paramas
    params.require(:book).permit(:title, :body)

  end
end
