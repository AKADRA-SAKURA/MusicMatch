class UsersController < ApplicationController
    def show
        @tweet = current_user.tweets.page(params[:page]).per(5)
        @user = User.where(user_id: current_user.id)
    end
end
