class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        render plain: "Thanks"
    end
end

# @user -> instance variable -> going to be visible in our view