class UsersController < ApplicationController
    def show
        @tweet = Tweet.where(user_id: current_user.id)
    end
end
