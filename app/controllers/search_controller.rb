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
    
end
