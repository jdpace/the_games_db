module TheGamesDB
  module Image
    class Format
      include SAXMachine

      ancestor :image
      value :path
      attribute :width
      attribute :height

      def url
        image.game.feed.base_image_url + path
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
