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

platforms = TheGamesDB::Platform.all
platforms.map(&:name)
=> ["3DO", "Amiga", "Amstrad CPC", "Android", "Arcade", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", ...]

xbox = TheGamesDB::Platform.find 15
xbox.name
=> "Microsoft Xbox 360"
xbox.consoles.first.url
=> "http://thegamesdb.net/banners/platform/consoleart/15.png"
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
    platforms (when using `.all`)
      platform.gbd_id
      platform.name
      platform.alias
    platform (when using `.find`)
  		platform.gbd_id
  		platform.name
  		platform.alias
  		platform.overview
  		platform.developer
  		platform.manufacturer
  		platform.cpu
  		platform.memory
  		platform.graphics
  		platform.sound
  		platform.resolution
  		platform.media
  		platform.max_controllers
  		platform.rating
      platform.banners
        banner.width
        banner.height
        banner.path
      platform.boxarts
        boxart.width
        boxart.height
        boxart.side
        boxart.path
      platform.fanarts
        fanart.original.width
        fanart.original.height
        fanart.original.path
        fanart.vignette.width
        fanart.vignette.height
        fanart.vignette.path
        fanart.thumb.path
  		platform.consoles
        console.path
  		platform.controllers
        controller.path


Copyright
---------

Copyright (c) 2011 Jared Pace. See LICENSE for details.
