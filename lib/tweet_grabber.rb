require "twitter"
load "secrets.json"

class TweetGrabber
  def self.get_text_of_tweets(username: "justinbieber", tweet_count: 500)
    new(username, tweet_count).get_full_text_of_tweets
  end

  def initialize(username, tweet_count)
    @username = username
    @tweet_count = [tweet_count, 500].min
    @client = initialize_client
  end

  def get_full_text_of_tweets
    get_timeline.map(&:full_text).join(" ")
  end

  def get_timeline
    @client.user_timeline(@username, count: @tweet_count)
  end

  def initialize_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token = ACCESS_TOKEN
      config.access_token_secret = ACCESS_TOKEN_SECRET
    end
  end
end
