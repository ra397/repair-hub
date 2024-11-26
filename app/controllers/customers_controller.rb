class CustomersController < ApplicationController
    before_action :require_login
    before_action :set_customer, only: [ :show, :edit, :update, :destroy ]

    def index
        @customers = current_user.customers
    end

    def show
        @tickets = @customer.tickets
    end

    def new
        @customer = current_user.customers.build
    end

    def create
        @customer = current_user.customers.build(customer_params)
        if @customer.save
            redirect_to customers_path, notice: "Customer was successfully created."
        else
            flash.now[:alert] = "Failed to create customer."
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @customer
    end

    def update
        if @customer.update(customer_params)
            redirect_to @customer, notice: "Customer was successfully updated."
        else
            flash.now[:alert] = "Failed to update customer."
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @customer.destroy
          redirect_to customers_path, notice: "Customer was successfully deleted."
        else
          redirect_to customers_path, alert: @customer.errors.full_messages.to_sentence
        end
    end

    private

    def customer_params
        params.require(:customer).permit(:name, :address, :phone_number, :email)
    end

    def set_customer
        @customer = current_user.customers.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to customers_path, alert: "Customer not found."
    end
end
