class SearchController < ApplicationController

    def search
        if params[:search] != nil && params[:search] != ''
            #部分検索かつ複数検索
            @tweets = Tweet.where("body LIKE ? ", "%" + params[:search] + "%").or(Tweet.where("tweet.user.name LIKE ? ", "%" + params[:search] + "%"))
        else
            @tweets = Tweet.all
        end
    end

    def result
    end
    
end
