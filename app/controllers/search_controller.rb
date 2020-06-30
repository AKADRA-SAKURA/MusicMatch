class SearchController < ApplicationController

    def search
        if params[:search] != nil && params[:search] != ''
            #部分検索かつ複数検索
            @tweets = Tweet.where("title LIKE ? ", "%" + params[:search] + "%").or(Tweet.where("artist LIKE ? ", "%" + params[:search] + "%"))
          else
            @tweets = Tweet.all.order(created_at: :desc)
        end
    end

    #def searchtag
    #    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    #    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    #    @tweets = @tag.tweets.all           #クリックしたタグに紐付けられた投稿を全て表示
    #end

    def result
    end
    
end
