class CustomersController < ApplicationController
    before_action :require_login
    before_action :set_customer, only: [ :show, :edit, :update, :destroy ]

    def index
        if params[:query].present?
        query = params[:query].downcase
        @customers = current_user.customers
                                .where("LOWER(name) LIKE :query OR LOWER(address) LIKE :query OR LOWER(phone_number) LIKE :query OR LOWER(email) LIKE :query", query: "%#{query}%")
                                .order(created_at: :desc)
                                .page(params[:page])
                                .per(25)
        else
        @customers = current_user.customers
                                .order(created_at: :desc)
                                .page(params[:page])
                                .per(25)
        end
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
