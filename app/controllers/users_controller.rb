class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_following'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_followers'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end
end
