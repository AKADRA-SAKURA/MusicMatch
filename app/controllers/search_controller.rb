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
      @tweets = Tweet.all
      @tags = Tag.all
      if params[:tagnum] != nil && params[:tagnum] != ''
        matchAlltags = TagRelation.where(tag_id: :tagnum).group(:tag_id).having('count(tweet_id) = ?', :tagnum.length)
        tweetIds = matchAlltags.map(&:tweet_id)
        @tag = Tag.where(id: tweetIds)
      else
        @tweet = Tweet.all        
      end
    end
  
  
    private
      def tweet_params
        params.require(:tweet).permit(:title, :artist, tags_ids: [] )
      end

    
end
