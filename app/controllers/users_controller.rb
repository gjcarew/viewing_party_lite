class UsersController < ApplicationController
  # before_action :logged_in_user, only: %i[show]
  def welcome
    session[:user_id] = 1
    redirect_to user_path
    # @user = current_user
  end

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcome, #{@user.name}"
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = "Error: Password doesn't match."
      render :new
    else
      flash[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def show
    @user = current_user
  end

  def discover
    @user = current_user
  end

  def results
    @user = current_user
    if params["q"] == "top rated"
      @movies = MovieFacade.get_top20_movies
    elsif params["Search by Movie Title"] != ""

      @movies = MovieFacade.get_movies(params["Search by Movie Title"])
    else
      flash.now[:alert] = "You must fill in a title."
      render :discover
    end
  end

  private 
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def authenticate_pw(user)
    if user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Incorrect password."
      render :login_form
    end
  end
end
