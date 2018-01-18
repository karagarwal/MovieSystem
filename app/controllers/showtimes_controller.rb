class ShowtimesController < ApplicationController
  def index
    showtimes = Showtime.all
    respond_to do |format|
      format.json { render json: { showtimes: showtimes }, status: :ok }
    end
  end

  def new
    @showtime = Showtime.new
    respond_to do |format|
      format.json { render json: { showtime: @showtime }, status: :ok }
    end
  end

  def show
    showtime = Showtime.find(params[:id])
    respond_to do |format|
      format.json { render json: { showtime: showtime }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    showtime = Showtime.new(showtime_params)
    respond_to do |format|
      if showtime.save
        format.json { render json: { showtime: showtime }, status: :ok }
      else
        format.json { render json: showtime.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def destroy
    showtime = Showtime.find(params[:id])
    respond_to do |format|
      showtime.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    showtime = Showtime.find(params[:id])
    respond_to do |format|
      if showtime.update(showtime_params)
        format.json { render json: { showtime: showtime }, status: :ok }
      else
        format.json { render json: showtime.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def showtime_params
    params.require(:showtime).permit(:timing, :movie_id)
  end
end
