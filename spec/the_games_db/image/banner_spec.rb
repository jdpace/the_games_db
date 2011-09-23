require 'spec_helper'

describe TheGamesDB::Image::Banner do

  before do
    game_xml = SpecRoot.join 'fixtures', 'game.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(game_xml.read)
  end

  let(:game)   { TheGamesDB::Game.find 140 }
  let(:banner) { game.banners.first }

  it 'is parsed correctly' do
    banner.width.should == 760
    banner.height.should == 140
    banner.path.should == "graphical/140-g.jpg"
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      banner.url.should == 'http://thegamesdb.net/banners/graphical/140-g.jpg'
    end
  end

end
