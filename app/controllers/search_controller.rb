class SearchController < ApplicationController

    def search
        if params[:search] != nil && params[:search] != ''
            #部分検索かつ複数検索
            @tweets = Tweet.where("title LIKE ? ", "%" + params[:search] + "%").or(Tweet.where("artist LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("used LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("composer LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("writer LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("record LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("published LIKE ? ", "%" + params[:search] + "%")).or(Tweet.where("online LIKE ? ", "%" + params[:search] + "%"))
          else
            @tweets = Tweet.all.order(created_at: :desc)
        end
    end

    def tagsearch
      #@tweets = Tweet.all
      @tags = Tag.all
      if params[:tag_ids] != nil && params[:tag_ids] != ''
        #:format == :tag_ids
        #@tag = Tag.where(params[:format])    
        selected_tag_ids = selected_tags_params # Tag id array checked with form.
        filtered_tweet_ids = Tweet.filter(selected_tag_ids) # Memo id array filtered with checked tag by And condition.
        @tag = Tweet.where(id: filtered_tweet_ids) # Memos instance selected with filtered memo ids.
      else
        @tag = Tweet.all
      end
      #if params[:keyword] != nil && params[:keyword] != ''
        #split_keywords = params[:keyword].split(/[[:blank:]]+/) # 空白で分割
        #@tag = Tag.where('tag LIKE(?)', "%#{params[:keyword]}%")
        #tagid = Tag.find_by(id: :@tag)
        #@tweet = Tweet.where(tag: tag)
        #@tag = Tag.find(params[:id])
        #matchAlltags = TagRelation.where(tag_id: :tagnum).group(:tag_id).having('count(tweet_id) = ?', :tagnum.length)
        #tweetIds = matchAlltags.map(&:tweet_id)
        #@tag = Tag.where(id: tweetIds)
      #else
        #@tweet = Tweet.all        
      #end
    end
  
  
    private
      def tweet_params
        params.require(:tweet).permit(:title, :artist, tags_ids: [] )
      end

      def selected_tags_params
        params.require(:tag_ids)
      end

      def filter(selected_tag_ids) # Tag id array checked with form.
        selected_tweet_ids = TagRelation.where(tag_id: selected_tag_ids).pluck(:tweet_id).uniq.sort # Memo id array associated to checked tag.
        return Tweet.all unless selected_tag_ids 
        tweet_filtered = [] # Memo id array associated to all tags checked with form.
        selected_tweet_ids.each do |id|
          loop_count = 0
          while selected_tag_ids.length > loop_count do
            break unless Tweet.includes(:tags).find(id).tags.pluck(:id).include?(selected_tag_ids[loop_count].to_i)
            loop_count += 1; # Get memo id that associated tag id is equall to all tag id selected.
          end
          tweet_filtered << id if loop_count == selected_tag_ids.length
        end
        return tweet_filtered
      end

    
end
