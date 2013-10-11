require 'the_games_db/image/format'

module TheGamesDB
  module Image
    class Fanart
      include SAXMachine

      ancestor :game
      ancestor :platform
      element :original, :class => TheGamesDB::Image::Format
      element :vignette, :class => TheGamesDB::Image::Format
      element :thumb,    :class => TheGamesDB::Image::Format
    end
  end
end
