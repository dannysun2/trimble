class TweetsController < ApplicationController
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order_by(:tweeted_at.desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tweets }
    end
  end

  def page
  end
  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/new
  # GET /tweets/new.json
  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tweet }
    end
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  def get_tweets
    @results = Tweet.where(:coordinates => {"$near" => [params[:latitude].to_i,params[:longitude].to_i] , '$maxDistance' => params[:radius].to_i.fdiv(69)})
    .order_by(:tweeted_at.desc).page(params[:page]).per(10)
    if params[:hashtags].present?
      hashtags = params[:hashtags].downcase.split(' ')
      @results = Tweet.where(:hashtags => hashtags)
      .order_by(:tweeted_at.desc).page(params[:page]).per(10)
    end
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      if @tweet.update_attributes(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def tweet_params
      params.require(:tweet).permit(:location, :message, :tweeted_at)
    end
end
