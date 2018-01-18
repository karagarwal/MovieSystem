class SeatTypesController < ApplicationController
  def index
    seat_types = SeatType.all
    respond_to do |format|
      format.json { render json: { seat_types: seat_types }, status: :ok }
    end
  end

  def new
    seat_type = SeatType.new
    respond_to do |format|
      format.json { render json: { seat_type: seat_type }, status: :ok }
    end
  end

  def show
    seat_type = SeatType.find(params[:id])
    respond_to do |format|
      format.json { render json: { seat_type: seat_type }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    seat_type = SeatType.new(seat_type_params)
    respond_to do |format|
      if seat_type.save
        format.json { render json: { seat_type: seat_type }, status: :ok }
      else
        format.json { render json: seat_type.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def destroy
    seat_type = SeatType.find(params[:id])
    respond_to do |format|
      seat_type.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    seat_type = SeatType.find(params[:id])
    respond_to do |format|
      if seat_type.update(seat_type_params)
        format.json { render json: { seat_type: seat_type }, status: :ok }
      else
        format.json { render json: seat_type.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def seat_type_params
    params.require(:seat_type).permit(:category, :audi_id)
  end
end
