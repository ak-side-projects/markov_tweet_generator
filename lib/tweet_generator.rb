require_relative "tweet_grabber"
require_relative "markov_generator"

class TweetGenerator
  def self.generate(username: "justinbieber", tweet_count: 500, order: 1,
                    max_chars: 280)
    text = TweetGrabber.get_text_of_tweets(
      username: username,
      tweet_count: tweet_count
    )

    MarkovGenerator.new(
      text: text,
      order: order,
      max_chars: max_chars
    ).generate
  end
end

p TweetGenerator.generate
