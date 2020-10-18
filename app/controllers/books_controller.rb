class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_paramas)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user_id
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = 'You have destroyed book successfully'
      redirect_to books_path
    else
      render :index
    end
  end

  private
  def book_paramas
    params.require(:book).permit(:title, :body)

  end
end
