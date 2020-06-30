class TweetsController < ApplicationController
  before_action :authenticate_user!

    def index
      @tweets= Tweet.all.all.page(params[:page]).per(20).order(created_at: :desc).includes(:user)
    end

    #def artist
      #@tweets= Tweet.where(artist: ).all.page(params[:page]).per(20).order(created_at: :desc).includes(:user)
    #end


    def ranking
      @all_ranks = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))
    end

    def new
      @tweet = Tweet.new
      @tags = Tag.all
      @tag = @tweet.tags.build
    end

    def create
      @tweet = Tweet.new(tweet_params)
      @tweet.user_id = current_user.id
      if @tweet.save
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
    end
    
    def show
      @tweet = Tweet.find(params[:id])
      @like = Like.new
      @comments = @tweet.comments
      @comment = @tweet.comments.build
    end

    def edit
      @tweet = Tweet.find(params[:id])
      @tags = Tag.all
      @tag = @tweet.tags.build
    end

    def update
      @tweet = Tweet.find(params[:id])
      if @tweet.update(tweet_params)
        redirect_to :action => "show", :id => @tweet.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy
      Tweet.find(params[:id]).destroy
      redirect_to action: :index
    end

    private
    def tweet_params
      params.require(:tweet).permit(:title, :artist, :writer, :composer, :published, :record, :image, tag_ids: [])
    end

end
