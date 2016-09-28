require 'yelp'

class Firstmodel < ActiveRecord::Base
  # before_create :send_tweet

  def search_yelp(search_var)
    begin
      if Yelp.client.configuration == nil
        Yelp.client.configure do |config|
          config.consumer_key = ENV['YELP_CONSUMER_KEY']
          config.consumer_secret = ENV['YELP_CONSUMER_SECRET']
          config.token = ENV['YELP_ACCESS_TOKEN']
          config.token_secret = ENV['YELP_ACCESS_TOKEN_SECRET']
      end
    end
      Yelp.client.search('Portland', { term: search_var })
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)["message"]
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
