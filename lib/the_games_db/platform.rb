require 'date'

module TheGamesDB
  class Platform
    include SAXMachine

    ancestor :feed
    element  :id,             :as => :gbd_id
    elements :Platform,       :as => :platforms
    element  :name,           :as => :name
    element  :alias,          :as => :alias
    element  :overview,       :as => :overview
    element  :developer,      :as => :developer
    element  :manufacturer,   :as => :manufacturer
    element  :cpu,            :as => :cpu
    element  :memory,         :as => :memory
    element  :graphics,       :as => :graphics
    element  :sound,          :as => :sound
    element  :display,        :as => :resolution
    element  :media,          :as => :media
    element  :maxcontrollers, :as => :max_controllers
    element  :Rating,         :as => :rating
    elements :banner,         :as => :banners,  :class => TheGamesDB::Image::Banner
    elements :boxart,         :as => :boxarts,  :class => TheGamesDB::Image::Boxart
    elements :fanart,         :as => :fanarts,  :class => TheGamesDB::Image::Fanart
    elements :consoleart,     :as => :consoles, :class => TheGamesDB::Image::Console
    elements :controllerart,  :as => :controllers, :class => TheGamesDB::Image::Controller

    attr_accessor :feed

    def self.all
      feed = TheGamesDB::Feed.fetch_and_parse('GetPlatformsList.php')
      feed.platforms
    end

    def self.find(id)
      feed = TheGamesDB::Feed.fetch_and_parse('GetPlatform.php', :id => id)
      feed.platforms.first || raise(TheGamesDB::Exception::PlatformNotFound.new id)
    end

    # TheGamesDB handles platform names in two ways:
    #
    # 1. GetPlatformsList.php simply sets the name under the 'name' element tag:
    #
    #   <Platform>
    #     <name>Microsoft Xbox 360</name>
    #     ...
    #   </Platform>
    #
    # 2. GetPlatform.php has two 'Platform' elements:
    #
    #   <Platform>
    #     <id>15</id>
    #     <Platform>Microsoft Xbox 360</Platform>
    #     ...
    #   </Platform>
    #
    # The `platforms` collection holds every unmatched element of the root 'Platform',
    # by overriding the following method we save only what we need (the name).
    def add_platforms(value)
      @name ||= value
    end

  end
end
