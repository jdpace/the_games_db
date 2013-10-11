module TheGamesDB
  module Image
    class Banner
      include SAXMachine

      ancestor :game
      ancestor :platform
      value :path
      attribute :width
      attribute :height

      def url
        game.feed.base_image_url + path
      end

      def width
        @width.to_i
      end

      def height
        @height.to_i
      end

    end
  end
end
