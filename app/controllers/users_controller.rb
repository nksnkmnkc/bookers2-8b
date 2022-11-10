class UsersController < ApplicationController
 before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    #過去７日分それぞれの投稿数を一覧表示する（表・グラフ）
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_day_ago_book = @books.created_two_day_ago
    @three_day_ago_book = @books.created_three_day_ago
    @four_day_ago_book = @books.created_four_day_ago
    @five_day_ago_book = @books.created_five_day_ago
    @six_day_ago_book = @books.created_six_day_ago
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
     redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
