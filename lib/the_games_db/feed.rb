module TheGamesDB
  class Feed
    include SAXMachine

    BaseApiUrl = "http://thegamesdb.net/api/"
    Timeout = 10_000 # milliseconds

    element  :baseImgUrl, :as => :base_image_url
    elements :Game, :as => :games, :class => TheGamesDB::Game
    elements :Platform, :as => :platforms, :class => TheGamesDB::Platform

    def self.fetch_and_parse(path, params={})
      parse fetch(path, params)
    end

    def self.fetch(path, params={})
      response = Typhoeus::Request.get(api_url(path), :params => params, :timeout => Timeout)

      bad_response!(response) unless response.success?
      response.body
    end

    def self.api_url(path)
      BaseApiUrl + path
    end

    def self.bad_response!(response)
      raise TheGamesDB::Exception::BadResponse.new(response.curl_error_message)
    end

  end
end
