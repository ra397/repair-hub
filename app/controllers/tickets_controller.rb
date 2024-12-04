class TicketsController < ApplicationController
  before_action :require_login
  before_action :set_ticket, only: %i[show invoice edit update destroy]
  before_action :check_business_info, only: [:invoice]

  def index
    if params[:query].present?
      query = params[:query].downcase
      @tickets = current_user.tickets
                             .joins(:customer)
                             .where("LOWER(ticket_number) LIKE :query OR LOWER(status) LIKE :query OR LOWER(customers.name) LIKE :query", query: "%#{query}%")
                             .order(created_at: :desc)
                             .page(params[:page])
                             .per(25)
    else
      @tickets = current_user.tickets
                             .order(created_at: :desc)
                             .page(params[:page])
                             .per(25)
    end
  end

  def show
    @line_items = @ticket.line_items
  end

  def invoice 
    session[:account_referrer] = 'ticket'
    session[:ticket_id] = @ticket.id
    @customer = @ticket.customer
    @line_items = @ticket.line_items
    @tax = @line_items.sum(:amount) * 0.06
    @processing_fee = (@line_items.sum(:amount) + @tax) * 0.03
    @total = @line_items.sum(:amount) + @tax + @processing_fee
  end

  def new
    @ticket = current_user.tickets.build
  end

  def create
    @ticket = current_user.tickets.build(ticket_params)
    if @ticket.save
      redirect_to tickets_path, notice: "Ticket was successfully created."
    else
      flash.now[:alert] = "Failed to create ticket. Please correct the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to tickets_path, notice: "Ticket was successfully updated."
    else
      flash.now[:alert] = "Failed to update ticket. Please correct the errors below."
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: "Ticket was successfully deleted."
  end

  private

  def set_ticket
    @ticket = current_user.tickets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tickets_path, alert: "Ticket not found."
  end

  def ticket_params
    params.require(:ticket).permit(:device_name, :device_model, :device_serial, :status, :customer_id)
  end

  def check_business_info
    unless current_user.business_info_complete?
      redirect_to edit_account_path(referrer: "ticket"), alert: "Please complete your business information to generate an invoice."
    end
  end
end
