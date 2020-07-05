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
      @q = Tweet.ransack(params[:q])
      @tweets = @q.result(distinct: true).order(created_at: :desc)
    end
  
  
    private
      def post_params
        params.require(:post).permit(:title, :details, label_ids: [] )
      end

    #def tagsearch
     # if params[:search] != nil && params[:search] != ''
      #  #部分検索かつ複数検索
       # tagname = Tag.where("tag LIKE ? ", "%" + params[:search] + "%")
   #   else
    #    tagname = Tag.all.order(created_at: :desc)
     # end 
      #tag = Tag.find_by(id: :format)    
      #@tweets = Tweet.where(tag: tag)
      #@tag = Tag.find(params[:format])
      #@tagall = Tag.all
   # end

    #def selected_tags_params
     # params.require(:tag_ids)
    #end
    
end
