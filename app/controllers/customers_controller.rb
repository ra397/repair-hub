class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :edit, :update, :destroy]

    def index
        @customers = Customer.all
    end

    def show
        @tickets = @customer.tickets
    end

    def new
        @customer = Customer.new
    end

    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            redirect_to customers_path, notice: 'Customer was successfully created.'
        else
            flash.now[:alert] = 'Failed to create customer.'
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @customer
    end

    def update
        if @customer.update(customer_params)
            redirect_to @customer, notice: 'Customer was successfully updated.'
        else
            flash.now[:alert] = 'Failed to update customer.'
            render :edit, status: :unprocessable_entity
        end 
    end

    def destroy
        if @customer.destroy
          redirect_to customers_path, notice: 'Customer was successfully deleted.'
        else
          redirect_to customers_path, alert: 'Failed to delete customer.'
        end
    end

    private

    def customer_params
        permitted_params = params.require(:customer).permit(:name, :address, :phone_number, :email)
        puts "Permitted Params: #{permitted_params.inspect}" # Debugging
        permitted_params
    end

    def set_customer
        @customer = Customer.find(params[:id])
    end
end
