require 'spec_helper'

describe TheGamesDB::Image::Console do

  before do
    platform_xml = SpecRoot.join 'fixtures', 'platform.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(platform_xml.read)
  end

  let(:platform) { TheGamesDB::Platform.find 15 }
  let(:console) { platform.consoles.first }

  it 'is parsed correctly' do
    console.path.should == "platform/consoleart/15.png"
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      console.url.should == 'http://thegamesdb.net/banners/platform/consoleart/15.png'
    end
  end

end
