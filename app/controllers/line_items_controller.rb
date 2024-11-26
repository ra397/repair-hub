class LineItemsController < ApplicationController
    before_action :set_ticket
    before_action :set_line_item, only: %i[edit update destroy]
  
    def new
      @line_item = @ticket.line_items.build
    end
  
    def create
      @line_item = @ticket.line_items.build(line_item_params)
      if @line_item.save
        redirect_to @ticket, notice: 'Line item was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit; end
  
    def update
      if @line_item.update(line_item_params)
        redirect_to @ticket, notice: 'Line item was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @line_item.destroy
      redirect_to @ticket, notice: 'Line item was successfully deleted.'
    end
  
    private
  
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end
  
    def set_line_item
      @line_item = @ticket.line_items.find(params[:id])
    end
  
    def line_item_params
      params.require(:line_item).permit(:description, :amount)
    end
end
  