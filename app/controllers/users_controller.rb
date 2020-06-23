class UsersController < ApplicationController

    def show
        @tweet = current_user.tweets.page(params[:page]).per(5)
    end

    def edit
    end
    
    def update
        if current_user.update(user_params)
            redirect_to  user_path(current_user)
        else
            redirect_to  edit_user_path(current_user)
        end
    end

    private
  
    def user_params
        params.fetch(:user, {}).permit(:user_name)
    end
end
