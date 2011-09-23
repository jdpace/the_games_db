require 'spec_helper'

describe TheGamesDB::Image::Fanart do

  before do
    game_xml = SpecRoot.join 'fixtures', 'game.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(game_xml.read)
  end

  let(:game)   { TheGamesDB::Game.find 140 }
  let(:fanart) { game.fanarts.first }

  it 'is parsed correctly' do
    fanart.original.should_not be_nil
    fanart.original.width.should == 1920
    fanart.original.height.should == 1080
    fanart.original.path.should == 'fanart/original/140-1.jpg'

    fanart.vignette.should_not be_nil
    fanart.vignette.width.should == 1920
    fanart.vignette.height.should == 1080
    fanart.vignette.path.should == 'fanart/vignette/140-1.jpg'

    fanart.thumb.should_not be_nil
    fanart.thumb.path.should == 'fanart/thumb/140-1.jpg'
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      fanart.original.url.should == 'http://thegamesdb.net/banners/fanart/original/140-1.jpg'
      fanart.vignette.url.should == 'http://thegamesdb.net/banners/fanart/vignette/140-1.jpg'
      fanart.thumb.url.should == 'http://thegamesdb.net/banners/fanart/thumb/140-1.jpg'
    end
  end

end
