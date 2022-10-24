class UsersController < ApplicationController

  def welcome
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
      flash[:notice] = "Welcome, #{@user.name}"
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = "Error: Password doesn't match."
      render :new
    else
      flash[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  def results
    @user = User.find(params[:id])
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
    params.permit(:email, :name, :password, :password_confirmation)
  end
end
