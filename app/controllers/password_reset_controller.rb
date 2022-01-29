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
        @user = User.find_by(reset_password_token: params[:token])
        if @user.present? && @user.password_token_valid?

        else
            redirect_to sign_in_path, alert: "Your token has expired. Please try agin later."
        end
    end

    def update
        @user = User.find_by(reset_password_token: params[:token])
        if @user.update(user_password)
            @user.set_token_null
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