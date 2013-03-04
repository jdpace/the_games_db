TheGamesDB: Ruby API Client
===========================

Simple API wrapper for TheGamesDB.net.

Installation
------------

```bash
gem install the_games_db
```


Usage
-----

```ruby
require 'the_games_db'
mario_games = TheGamesDB::Game.search :name => 'Super Mario Bros'
mario_games.first.title
 => "New Super Mario Bros."

smb3 = TheGamesDB::Game.find 112
smb3.title
 => "Super Mario Bros. 3"
smb3.platform
 => "Nintendo Entertainment System (NES)"
front_boxart = smb3.boxarts.detect {|boxart| boxart.side == "front"}
front_boxart.url
 => "http://thegamesdb.net/banners/boxart/original/front/112-2.jpg"
```


Available Properties
--------------------

    game.gbd_id
    game.title
    game.overview
    game.platform
    game.esrb
    game.players
    game.cooperative
    game.publisher
    game.developer
    game.release_date
    game.rating
    game.youtube_video
    game.genres
    game.banners
      banner.width
      banner.height
      banner.path
    game.boxarts
      boxart.width
      boxart.height
      boxart.side
      boxart.path
    game.fanarts
      fanart.original.width
      fanart.original.height
      fanart.original.path
      fanart.vignette.width
      fanart.vignette.height
      fanart.vignette.path
      fanart.thumb.path
    game.screenshots
      screenshot.original.width
      screenshot.original.height
      screenshot.original.path
      screenshot.thumb.path


Copyright
---------

Copyright (c) 2011 Jared Pace. See LICENSE for details.
