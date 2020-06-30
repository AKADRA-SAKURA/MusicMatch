class TagsController < ApplicationController
    def index
        @tags = Tag.all
    end

    def new
        @tag = Tag.new
    end

    def create
        @tags = Tag.new(tag_params)
        @tags.user_id = current_user.id
    
        #新しいTweetの保存に成功した場合
        if @tags.save
          #index.html.erbにページが移る
          redirect_to action: "index"
        #新しいTweetの保存に失敗した場合
        else
          #もう一回投稿画面へ
          redirect_to action: "new"
        end
    end

    def destroy
        Tag.find(params[:id]).destroy
        redirect_to action: :index
    end

    private
    def tag_params
      params.require(:tag).permit(:tag)
    end
end
