class PasswordController < ApplicationController
    before_action :require_user_logged_in!
    
    def edit
    end

    def update
        if @user_current.update(user_password)
            redirect_to root_path, notice: "Password updated"
        else 
            render :edit
        end
    end

    private

    def user_password
        params.require(:user).permit(:password, :password_confirmation)
    end
end