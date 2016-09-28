require 'yelp'

class Firstmodel < ActiveRecord::Base
  # before_create :send_tweet

  def search_yelp(search_var)
    begin
      Yelp.client.search('Portland', { term: search_var })
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)["message"]
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
