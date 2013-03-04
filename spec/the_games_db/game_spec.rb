require 'spec_helper'

describe TheGamesDB::Game do

  context '.search' do
    it 'hits the GetGamesList API endpoint' do
      TheGamesDB::Feed.expects(:fetch_and_parse).with('GetGamesList.php', :name => 'Mario').returns(stub_everything)
      TheGamesDB::Game.search(:name => 'Mario')
    end
  end

  context '.find' do
    it 'hits the GetGame API endpoint' do
      feed = stub 'feed', :games => [stub('game')]
      TheGamesDB::Feed.expects(:fetch_and_parse).with('GetGame.php', :id => 140).returns(feed)
      TheGamesDB::Game.find 140
    end

    context 'when the game is found' do
      let(:game) { stub 'game' }

      before do
        feed = stub 'feed', :games => [game]
        TheGamesDB::Feed.expects(:fetch_and_parse).returns(feed)
      end

      it 'returns the game' do
        TheGamesDB::Game.find(140).should == game
      end
    end

    context 'when the game is not found' do
      before do
        feed = stub 'feed', :games => []
        TheGamesDB::Feed.expects(:fetch_and_parse).returns(feed)
      end

      it 'raises a not found error' do
        expect do
          TheGamesDB::Game.find(-1)
        end.to raise_error(TheGamesDB::Exception::GameNotFound)
      end
    end
  end

  context 'when parsed' do
    before do
      game_xml = SpecRoot.join 'fixtures', 'game.xml'
      TheGamesDB::Feed.stubs(:fetch).returns(game_xml.read)
    end

    let(:game) { TheGamesDB::Game.find 140 }

    it 'correctly parses the values' do
      game.gbd_id.should == "140"
      game.title.should == "Super Mario Bros."
      game.overview.should =~ /^The player takes the role of Mario/
      game.platform.should == "Nintendo Entertainment System (NES)"
      game.esrb.should == "E - Everyone"
      game.players.should == "2"
      game.cooperative.should == "No"
      game.publisher.should == "Nintendo"
      game.developer.should == "Nintendo"
      game.release_date.should == Date.parse("September 13, 1985")
      game.genres.should include('Adventure', 'Platform')

      game.banners.should_not be_empty
      game.banners.first.should be_a TheGamesDB::Image::Banner

      game.boxarts.should_not be_empty
      game.boxarts.first.should be_a TheGamesDB::Image::Boxart

      game.fanarts.should_not be_empty
      game.fanarts.first.should be_a TheGamesDB::Image::Fanart

      game.screenshots.should_not be_empty
      game.screenshots.first.should be_a TheGamesDB::Image::Screenshot
    end
  end

end
