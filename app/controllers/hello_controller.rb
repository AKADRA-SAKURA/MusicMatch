class HelloController < ApplicationController
    
    def index
        @tweets = Tweet.order(created_at: :desc).limit(3)
        @all_ranks = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))
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
