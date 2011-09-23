module TheGamesDB
  module Exception

    class BadResponse < StandardError
      def initialize(message)
        super "Error Fetching Data from TheGamesDB: #{message}"
      end
    end

    class GameNotFound < StandardError
      def initialize(id)
        super "Game Not Found: id = #{id}"
      end
    end

  end
end
