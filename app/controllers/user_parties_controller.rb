class UserPartiesController < ApplicationController
  before_action :logged_in_user, only: :new
  def new
    @user = current_user
    @movie = MovieFacade.movie_by_id(params[:movie_id])
  end

  def create
    @user = current_user
    party = Party.new(party_params)
    @movie = MovieFacade.movie_by_id(params[:movie_id])

    if @movie.runtime > party.duration
      redirect_to "/dashboard/movies/#{@movie.id}/viewing-party/new"
      flash[:alert] = 'The duration can not be shorter than the run time of the movie, silly.'
    elsif party.save
      PartyMaker.make_party(@user.id, party.id, params[:invitees])
      redirect_to user_path
    else
      flash.now[:alert] = 'Please use a valid time and date'
      render :new
    end
  end

  private

  def party_params
    params.permit(:start_time, :duration, :date, :movie_id)
  end
end
