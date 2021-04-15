class MoviesController < ApplicationController
  def new
    @movies = Movie.new
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
      end
    end
  end

  def show
     @movies = Movie.find(params.fetch(:id))
  end

  def create
    @movies = Movie.new
    @movies.title = params.fetch(:title)
    @movies.description = params.fetch(:description)

    if @movies.valid?
      @movies.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "new" 
    end
  end

  def edit
    @movies = Movie.find(params.fetch(:id))
  end

  def update
    @movies = Movie.find(params.fetch(:id))

    @movies.title = params.fetch(:title)
    @movies.description = params.fetch(:description)

    if @movies.valid?
      @movies.save
      redirect_to movie_url(@movies), notice: "Movie updated successfully." 
    else
      redirect_to movie_url(@movies), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    @movies = Movie.find(params.fetch(:id))

    @movies.destroy

    redirect_to("/movies",  :notice => "Movie deleted successfully." )
  end
end
