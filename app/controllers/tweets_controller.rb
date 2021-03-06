class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :artist, :ranking]

    def index
      @tweets= Tweet.all.all.page(params[:page]).per(20).order(created_at: :desc).includes(:user)
    end

    def artist
      @art = Tweet.find(params[:format]).artist
      @tweets = Tweet.where(artist: @art)
    end

    def ranking
      @all_ranks = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) desc').limit(3).pluck(:tweet_id))
    end

    def new
      @tweet = Tweet.new
      @tags = Tag.all.order(tag: :desc)
    end

    def create
      @tweet = Tweet.new(tweet_params)
      @tweet.user_id = current_user.id
      
      url = params[:tweet][:movieurl]
      url = url.last(11)
      @tweet.movieurl = url

      if @tweet.save
        redirect_to "/tweets/#{@tweet.id}/edit"
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
      @tags = Tag.all.order(tag: :asc)
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
      params.require(:tweet).permit(:title, :artist, :writer, :composer, :year, :published, :record, :image, :used, :movieurl, { :tag_ids => []})
    end

end
