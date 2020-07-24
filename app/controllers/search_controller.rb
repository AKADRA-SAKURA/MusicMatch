class SearchController < ApplicationController

    def search
        if params[:search] != nil && params[:search] != ''
            @tweets = Tweet.where("title LIKE ? ", "%" + params[:search] + "%").or(Tweet.where("artist LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("used LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("composer LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("writer LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("record LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("published LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("online LIKE ? ", "%" + params[:search] + "%"))
          else
            @tweets = Tweet.all.order(created_at: :desc)
        end
    end

    def tagsearch
      @tags = Tag.all.order(tag: :asc)
      if params[:tag_ids] != nil && params[:tag_ids] != '' 
        selected_tag_ids = selected_tags_params 
        filtered_tweet_ids = filter(selected_tag_ids) 
        @tag = Tweet.where(id: filtered_tweet_ids).page(params[:page]).per(20).order(created_at: :desc).includes(:user) 
      else
        @tag = Tweet.all.all.page(params[:page]).per(20).order(created_at: :desc).includes(:user)
      end
    end
  
  
    private
      def tweet_params
        params.require(:tweet).permit(:title, :artist, tags_ids: [] )
      end

      def selected_tags_params
        params.require(:tag_ids)
      end

      def filter(selected_tag_ids)
        selected_tweet_ids = TagRelation.where(tag_id: selected_tag_ids).pluck(:tweet_id).uniq.sort 
        return Tweet.all unless selected_tag_ids 
        tweet_filtered = [] 
        selected_tweet_ids.each do |id|
          loop_count = 0
          while selected_tag_ids.length > loop_count do
            break unless Tweet.includes(:tags).find(id).tags.pluck(:id).include?(selected_tag_ids[loop_count].to_i)
            loop_count += 1; 
          end
          tweet_filtered << id if loop_count == selected_tag_ids.length
        end
        return tweet_filtered
      end

    
end
