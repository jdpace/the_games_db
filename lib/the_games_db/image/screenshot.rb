require 'the_games_db/image/format'

module TheGamesDB
  module Image
    class Screenshot
      include SAXMachine

      ancestor :game
      element :original, :class => TheGamesDB::Image::Format
      element :thumb,    :class => TheGamesDB::Image::Format
    end
  end
end
