require 'spec_helper'

describe TheGamesDB::Image::Boxart do

  before do
    game_xml = SpecRoot.join 'fixtures', 'game.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(game_xml.read)
  end

  let(:game)   { TheGamesDB::Game.find 140 }
  let(:boxart) { game.boxarts.first }

  it 'is parsed correctly' do
    boxart.side.should == "front"
    boxart.width.should == 709
    boxart.height.should == 1000
    boxart.path.should == "boxart/original/front/140-1.jpg"
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      boxart.url.should == 'http://thegamesdb.net/banners/boxart/original/front/140-1.jpg'
    end
  end

end
