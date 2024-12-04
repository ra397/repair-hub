class AccountsController < ApplicationController
    before_action :require_login

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        @user.require_business_info = true
        if @user.update(account_params)
            redirect_to root_path, notice: "Account information updated!"
          else
            render :edit, status: :unprocessable_entity
        end      
    end

    private

    def account_params
        params.require(:user).permit(:business_name, :business_address, :business_phone)
    end
end
