require 'spec_helper'

describe TheGamesDB::Platform do

  context '.all' do
    it 'hits the GetPlatformsList API endpoint' do
      TheGamesDB::Feed.expects(:fetch_and_parse).with('GetPlatformsList.php').returns(stub_everything)
      TheGamesDB::Platform.all
    end

    context 'when parsed' do
      before do
        platforms_xml = SpecRoot.join 'fixtures', 'platforms.xml'
        TheGamesDB::Feed.stubs(:fetch).returns(platforms_xml.read)
      end

      let(:platform) { TheGamesDB::Platform.all.first }

      it 'correctly parses the values' do
        platform.gbd_id.should == "25"
        platform.name.should == "3DO"
        platform.alias.should == "3do"
      end
    end
  end

  context '.find' do
    it 'hits the GetPlatform API endpoint' do
      feed = stub 'feed', :platforms => [stub('platform')]
      TheGamesDB::Feed.expects(:fetch_and_parse).with('GetPlatform.php', :id => 15).returns(feed)
      TheGamesDB::Platform.find 15
    end

    context 'when the platform is found' do
      let(:platform) { stub 'platform' }

      before do
        feed = stub 'feed', :platforms => [platform]
        TheGamesDB::Feed.expects(:fetch_and_parse).returns(feed)
      end

      it 'returns the platform' do
        TheGamesDB::Platform.find(15).should == platform
      end
    end

    context 'when the platform is not found' do
      before do
        feed = stub 'feed', :platforms => []
        TheGamesDB::Feed.expects(:fetch_and_parse).returns(feed)
      end

      it 'raises a not found error' do
        expect do
          TheGamesDB::Platform.find(-1)
        end.to raise_error(TheGamesDB::Exception::PlatformNotFound)
      end
    end

    context 'when parsed' do
      before do
        platform_xml = SpecRoot.join 'fixtures', 'platform.xml'
        TheGamesDB::Feed.stubs(:fetch).returns(platform_xml.read)
      end

      let(:platform) { TheGamesDB::Platform.find 15 }

      it 'correctly parses the values' do
        platform.gbd_id.should == "15"
        platform.name.should == "Microsoft Xbox 360"
        platform.overview.should =~ /^The Xbox 360 is the second/
        platform.developer.should == "Microsoft"
        platform.manufacturer.should == "Microsoft"
        platform.cpu.should == "3.2 GHz PowerPC Tri-Core Xenon"
        platform.memory.should == "512 MB of GDDR3 RAM clocked at 700 MHz"
        platform.graphics.should == "500 MHz ATI Xenos"
        platform.sound.should == "Dolby Digital 5.1 (TOSLINK and HDMI)"
        platform.resolution.should == "1920x1080"
        platform.media.should == "Disc"
        platform.max_controllers.should == "4"
        platform.rating.should == "7.3333"

        platform.banners.should_not be_empty
        platform.banners.first.should be_a TheGamesDB::Image::Banner

        platform.boxarts.should_not be_empty
        platform.boxarts.first.should be_a TheGamesDB::Image::Boxart

        platform.fanarts.should_not be_empty
        platform.fanarts.first.should be_a TheGamesDB::Image::Fanart

        platform.consoles.should_not be_empty
        platform.consoles.first.should be_a TheGamesDB::Image::Console

        platform.controllers.should_not be_empty
        platform.controllers.first.should be_a TheGamesDB::Image::Controller
      end
    end
  end

end
