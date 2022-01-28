class PasswordResetController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            @user.send_password_reset
        end

        redirect_to root_path notice: "If an account with that email found, we have sent a link to reset your password"
    end

    def edit
    end

    def update
    end
end