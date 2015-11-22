class TweetsController < ActionController::Base
  layout 'application'
  def create
    begin
      params[:tweet][:user_id] = current_user.try(:id)
      tweet_params = TweetParameter.new(params[:tweet])
      raise '不正な画像' if tweet_params.img_data.present? && tweet_params.img_data == 'INVALID_IMAGE'
      raise '不正な文字数' if tweet_params.text.present? && tweet_params.text == 'INVALID_TEXT_SIZE'
      @tweet = Tweet.new(text: tweet_params.text, user_id: tweet_params.user_id, img_data: tweet_params.img_data, mine: tweet_params.mine)

      if @tweet.save
        async_tweet(@tweet)
        redirect_to root_path, notice: '時限ツイート成功！'
      else
        redirect_to root_path, notice: '時限ツイートうまくいってないかも！'
      end
    rescue => e
      flash[:error] = "#{e.message}のせいでツイート失敗！@razokuloverに報告してくれ！"
      redirect_to root_path
    end
  end

  private
  def async_tweet(tweet)
    access_token = current_user.access_token
    secret_token = current_user.secret_token
    Resque.enqueue(TwitterWorker, access_token, secret_token, tweet.id, tweet.text)
  end
end
