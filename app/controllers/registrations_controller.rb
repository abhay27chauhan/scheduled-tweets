class RegistrationsController < ApplicationController
    def new  
        if @user_current
            redirect_to root_path
        end
        @user = User.new
    end

    def create
        # @user = User.new(params[:user])
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account"
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end

# @user -> instance variable -> going to be visible in our view
# render plain: params -> {"utf8"=>"✓", "authenticity_token"=>"IA16PoBNWHeFNuKMWCMYGT9gVMy/47snqXmGK3rSAUh+vAPhCvpxCzCGJnD0QxP+rFX958uFvKTMojtoac2Mww==", "user"=>{"email"=>"abc@gmail.com", "password"=>"password", "password_confirmation"=>"password"}, "commit"=>"Create User", "controller"=>"registrations", "action"=>"create"}
# render plain: params[:user] => {"email"=>"abc@gmail.com", "password"=>"password", "password_confirmation"=>"password"}