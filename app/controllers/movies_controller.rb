class MoviesController < ApplicationController
  def index
    movies = Movie.all
    respond_to do |format|
      format.json { render json: { movies: movies }, status: :ok }
    end
  end

  def new
    movie = Movie.new
    respond_to do |format|
      format.json { render json: { movie: movie }, status: :ok }
    end
  end

  def show
    movie = Movie.find(params[:id])
    respond_to do |format|
      format.json { render json: { movie: movie }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    movie = Movie.new(movie_params)
    respond_to do |format|
      if movie.save
        format.json { render json: { movie: movie }, status: :ok }
      else
        format.json { render json: movie.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    respond_to do |format|
      movie.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    movie = Movie.find(params[:id])
    respond_to do |format|
      if movie.update(movie_params)
        format.json { render json: { movie: movie }, status: :ok }
      else
        format.json { render json: movie.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :rating, :duration, :language, :theater_id, :audi_id)
  end
end
