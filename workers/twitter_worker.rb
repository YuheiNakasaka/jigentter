class TwitterWorker
  @queue = :resque_jt

  def self.perform(atoken,stoken,id,text)
    begin
      # 初期化
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['JIGENTTER_TWITTER_API_KEY']
        config.consumer_secret = ENV['JIGENTTER_TWITTER_API_SECRET']
        config.access_token = atoken
        config.access_token_secret = stoken
      end

      # 対象ツイート取得
      @tweet = Tweet.find(id)

      # 画像ある場合とない場合
      if @tweet.try(:img_data).present?
        ext = @tweet.mine.sub(/image\//,"")
        filename = "/tmp/#{Time.now.to_i}-#{id}.#{ext}"
        file = File.open(filename, "wb")
        file.puts(@tweet.img_data)
        file.close
        res = client.update_with_media(text, File.new(filename))
        File.unlink(filename)
      else
        res = client.update(text)
      end

      # ツイート結果のidを保存してfile消しとく
      @tweet.tweet_identifier = res.id
      @tweet.save!
    rescue => e
      Rails.application.config.resque_logger.fatal("failed to tweet. Error: #{e}")
    end
  end
end