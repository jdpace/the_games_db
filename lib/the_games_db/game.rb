require 'date'

module TheGamesDB
  class Game
    include SAXMachine

    parent   :feed
    element  :id
    element  :GameTitle,   :as => :title
    element  :Overview,    :as => :overview
    element  :Platform,    :as => :platform
    element  :ESRB,        :as => :esrb
    element  :Players,     :as => :players
    element  :'Co-op',     :as => :cooperative
    element  :Publisher,   :as => :publisher
    element  :Developer,   :as => :developer
    element  :ReleaseDate, :as => :release_date
    element  :Rating,      :as => :rating
    element  :Youtube,     :as => :youtube_video
    elements :genre,       :as => :genres
    elements :banner,      :as => :banners, :class => TheGamesDB::Image::Banner
    elements :boxart,      :as => :boxarts, :class => TheGamesDB::Image::Boxart
    elements :fanart,      :as => :fanarts, :class => TheGamesDB::Image::Fanart
    elements :screenshot,  :as => :screenshots, :class => TheGamesDB::Image::Screenshot

    attr_accessor :feed

    def self.search(params = {})
      feed = TheGamesDB::Feed.fetch_and_parse('GetGamesList.php', params)
      feed.games
    end

    def self.find(id)
      feed = TheGamesDB::Feed.fetch_and_parse('GetGame.php', :id => id)

      feed.games.first || raise(TheGamesDB::Exception::GameNotFound.new id)
    end

    def release_date
      return unless @release_date

      month, day, year = @release_date.split('/').map(&:to_i)
      Date.civil year, month, day
    end

  end
end
