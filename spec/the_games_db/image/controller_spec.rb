require 'spec_helper'

describe TheGamesDB::Image::Controller do

  before do
    platform_xml = SpecRoot.join 'fixtures', 'platform.xml'
    TheGamesDB::Feed.stubs(:fetch).returns(platform_xml.read)
  end

  let(:platform) { TheGamesDB::Platform.find 15 }
  let(:controller) { platform.controllers.first }

  it 'is parsed correctly' do
    controller.path.should == "platform/controllerart/15.png"
  end

  context '#url' do
    it 'is composed of the base image url and the path' do
      controller.url.should == 'http://thegamesdb.net/banners/platform/controllerart/15.png'
    end
  end

end
