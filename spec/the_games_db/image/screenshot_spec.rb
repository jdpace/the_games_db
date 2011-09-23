require 'spec_helper'

describe TheGamesDB::Image::Screenshot do

  before do
    game_xml = SpecRoot.join 'fixtures', 'game.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(game_xml.read)
  end

  let(:game)   { TheGamesDB::Game.find 140 }
  let(:screenshot) { game.screenshots.first }

  it 'is parsed correctly' do
    screenshot.original.should_not be_nil
    screenshot.original.width.should == 256
    screenshot.original.height.should == 232
    screenshot.original.path.should == 'screenshots/140-1.jpg'

    screenshot.thumb.should_not be_nil
    screenshot.thumb.path.should == 'screenshots/thumb/140-1.jpg'
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      screenshot.original.url.should == 'http://thegamesdb.net/banners/screenshots/140-1.jpg'
      screenshot.thumb.url.should == 'http://thegamesdb.net/banners/screenshots/thumb/140-1.jpg'
    end
  end

end
