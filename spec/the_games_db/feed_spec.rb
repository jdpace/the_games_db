require 'spec_helper'

describe TheGamesDB::Feed do

  let(:xml) { SpecRoot.join('fixtures', 'game.xml').read }

  context ".fetch" do
    context 'when the request was successful' do
      before do
        expected_url = "http://thegamesdb.net/api/GetGame.php"
        successful_response = stub 'response', :success? => true, :body => xml
        Typhoeus::Request.expects(:get).
          with(expected_url, :params => {:id => 140}, :timeout => TheGamesDB::Feed::Timeout).
          returns(successful_response)
      end

      it 'returns the XML response' do
        TheGamesDB::Feed.fetch('GetGame.php', :id => 140).should == xml
      end
    end

    context 'when the request was unsuccessful' do
      let(:xml) { SpecRoot.join('fixtures', 'game.xml').read }
      before do
        expected_url = "http://thegamesdb.net/api/GetGame.php"
        error_response = stub 'response', :success? => false, :code => 500, :curl_error_message => '500'
        Typhoeus::Request.expects(:get).
          with(expected_url, :params => {:id => 140}, :timeout => TheGamesDB::Feed::Timeout).
          returns(error_response)
      end

      it 'raises an exception' do
        expect do
          TheGamesDB::Feed.fetch('GetGame.php', :id => 140)
        end.to raise_error(TheGamesDB::Exception::BadResponse)
      end
    end

    context 'when the request times out' do
      let(:xml) { SpecRoot.join('fixtures', 'game.xml').read }
      before do
        expected_url = "http://thegamesdb.net/api/GetGame.php"
        error_response = stub 'response', :success? => false, :timed_out? => true, :curl_error_message => 'Timed out'
        Typhoeus::Request.expects(:get).
          with(expected_url, :params => {:id => 140}, :timeout => TheGamesDB::Feed::Timeout).
          returns(error_response)
      end

      it 'raises an exception' do
        expect do
          TheGamesDB::Feed.fetch('GetGame.php', :id => 140)
        end.to raise_error(TheGamesDB::Exception::BadResponse)
      end
    end
  end

  context '.fetch_and_parse' do
    before do
      TheGamesDB::Feed.expects(:fetch).with('GetGame.php', :id => 140).returns(xml)
    end

    it 'parses the XML response' do
      feed = TheGamesDB::Feed.fetch_and_parse 'GetGame.php', :id => 140
      feed.base_image_url.should == "http://thegamesdb.net/banners/"
      feed.games.should_not be_empty
    end
  end

end
