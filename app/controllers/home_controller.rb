class HomeController < ActionController::Base
  layout 'application'
  def index
    if current_user.present?
      @tweet = Tweet.new
      @mytweets = Tweet.where(user_id: current_user.id).where.not(tweet_identifier: nil).order(:id).reverse_order.limit(100)
      @screen_name = current_user.name
    end
  end
end
