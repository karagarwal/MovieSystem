class TheatersController < ApplicationController
  def index
    theaters = Theater.all
    respond_to do |format|
      format.json { render json: { theaters: theaters }, status: :ok }
    end
  end

  def new
    @theater = Theater.new
    respond_to do |format|
      format.json { render json: { theater: @theater }, status: :ok }
    end
  end

  def show
    theater = Theater.find(params[:id])
    respond_to do |format|
      format.json { render json: { theater: theater }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    theater = Theater.new(theater_params)
    respond_to do |format|
      if theater.save
        format.json { render json: { theater: theater }, status: :ok }
      else
        format.json { render json: theater.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    theater = Theater.find(params[:id])
    respond_to do |format|
      theater.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    theater = Theater.find(params[:id])
    respond_to do |format|
      if theater.update(theater_params)
        format.json { render json: { theater: theater }, status: :ok }
      else
        format.json { render json: theater.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def theater_params
    params.require(:theater).permit(:theater_name, :address, :phone)
  end
end
