require 'sinatra_helper'
require_relative '../app/main'

describe 'API' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /artists/' do
    before(:all) do
      DB.conn.with do |conn|
        conn.exec(%{
          TRUNCATE artists;
          INSERT INTO artists (id, name) VALUES
            ('11111111-2222-3333-4444-555555555555', 'Bon Jovi'),
            ('aaaaaaaa-bbbb-cccc-4ddd-eeeeeeeeeeee', 'Springsteen');
       })
      end
    end

    before do
      get '/artists/'
    end

    it 'should be successful' do
      expect(last_response).to be_ok
    end

    it 'should be a json response' do
      expect(last_response.content_type).to eq('application/json')
    end

    it 'returns a list of all artists' do
      response_data = JSON.parse(last_response.body)
      expect(response_data).to eq([
        {'id'=>'11111111-2222-3333-4444-555555555555', 'name'=>'Bon Jovi'},
        {"id"=>"aaaaaaaa-bbbb-cccc-4ddd-eeeeeeeeeeee", "name"=>"Springsteen"},
      ])
    end
  end
end
