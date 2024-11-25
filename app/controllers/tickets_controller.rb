class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to tickets_path, notice: 'Ticket was successfully created.'
    else
      flash.now[:alert] = 'Failed to create ticket. Please correct the errors below.'
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to tickets_path, notice: 'Ticket was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update ticket. Please correct the errors below.'
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: 'Ticket was successfully deleted.'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:device_name, :device_model, :device_serial, :status, :customer_id)
  end
end
