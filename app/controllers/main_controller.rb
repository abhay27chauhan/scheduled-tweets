class MainController < ApplicationController
    def index
       if session[:user_id]
            @user = User.find_by(id: session[:user_id])
       end
    end
end

# find will give error if user does not exists but find_by don't