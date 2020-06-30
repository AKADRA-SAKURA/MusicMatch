class SearchController < ApplicationController

    def search
        if params[:search] != nil && params[:search] != ''
            #部分検索かつ複数検索
            @tweets = Tweet.where("title LIKE ? ", "%" + params[:search] + "%").or(Tweet.where("artist LIKE ? ", "%" + params[:search] + "%"))
          else
            @tweets = Tweet.all.order(created_at: :desc)
        end
    end

    def tagsearch
        if params[:tag_id]
          @selected_tag = Tag.find(params[:tag_id])
          @tweets= Tweet.from_tag(params[:tag_id]).page(params[:page])
        else
          @tweets= Tweet.all.page(params[:page])
        end
    end


    def result
    end
    
end
