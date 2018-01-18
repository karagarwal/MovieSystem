class TicketsController < ApplicationController
  def index
    tickets = Ticket.all
    respond_to do |format|
      format.json { render json: { tickets: tickets }, status: :ok }
    end
  end

  def new
    ticket = Ticket.new
    respond_to do |format|
      format.json { render json: { ticket: ticket }, status: :ok }
    end
  end

  def show
    ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.json { render json: { ticket: ticket }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def create
    ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if ticket.save
        format.json { render json: { ticket: ticket }, status: :ok }
      else
        format.json { render json: ticket.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    respond_to do |format|
      ticket.destroy
      format.json { render json: { message: 'Deleted' }, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  def update
    ticket = Ticket.find(params[:id])
    respond_to do |format|
      if ticket.update(ticket_params)
        format.json { render json: { ticket: ticket }, status: :ok }
      else
        format.json { render json: ticket.errors, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:seat_number, :price, :movie_id, :audi_id, :showtime_id, :seat_type_id, :user_id)
  end
end
