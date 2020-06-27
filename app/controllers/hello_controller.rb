class HelloController < ApplicationController
    
    def index
        @tweets = Tweet.order(created_at: :desc).limit(3)
    end

    def create
    end

    def show
    end

    def search
    end

    def mypage
    end

    def link
    end

end
