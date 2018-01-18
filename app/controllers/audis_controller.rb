class AudisController < ApplicationController
  def index
    audis = Audi.all
    respond_to do |format|
      format.json { render json: { audis: audis }, status: :ok }
    end
  end

  def new
    @audi = Audi.new
    respond_to do |format|
      format.json { render json: { audi: @audi }, status: :ok }
    end
  end

  def show
    audi = Audi.find(params[:id])
    respond_to do |format|
      format.json { render json: { audi: audi }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    audi = Audi.new(audi_params)
    respond_to do |format|
      if audi.save
        format.json { render json: { audi: audi }, status: :ok }
      else
        format.json { render json: audi.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def destroy
    audi = Audi.find(params[:id])
    respond_to do |format|
      audi.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    audi = Audi.find(params[:id])
    respond_to do |format|
      if audi.update(audi_params)
        format.json { render json: { audi: audi }, status: :ok }
      else
        format.json { render json: audi.errors, status: :unprocessable_entity }
      end
    end
  rescue => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def audi_params
    params.require(:audi).permit(:code, :number_of_seats, :theater_id)
  end
end
