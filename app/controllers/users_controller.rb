class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user_recipes = @user.recipes.page(params[:page]).per(10)

  end

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      flash[:success] = 'new user is successfully created'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    user_params.delete('id')

    if @user.update(user_params)
      flash[:success] = 'your account was successfully updated'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end 

  def destroy

  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'You can only edit and delete your own account'
      redirect_to users_path
    end
  end  
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :avatar, :password, :password_confirmation)
  end
end
