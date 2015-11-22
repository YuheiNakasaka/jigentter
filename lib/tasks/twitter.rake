# coding: utf-8
namespace :twitter do
  desc "ツイート削除"
  task :delete , [:type] => :environment do |task, args|
    type =  args[:type]
    Tweet.includes(:user).where("created_at < ?", 1.hour.ago).find_each do |tweet|
      user = tweet.user
      cli = client(user.access_token, user.secret_token)
      cli.destroy_status(tweet.tweet_identifier)
      tweet.destroy
      log("successfully delete! id: #{tweet.id}")
    end
  end

  def client(atoken,stoken)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['JIGENTTER_TWITTER_API_KEY']
      config.consumer_secret = ENV['JIGENTTER_TWITTER_API_SECRET']
      config.access_token = atoken
      config.access_token_secret = stoken
    end
  end

  def log(text)
    puts "[#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}] #{text}"
  end
end
